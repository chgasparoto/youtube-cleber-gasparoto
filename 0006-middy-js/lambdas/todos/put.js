const DynamoDB = require('aws-sdk/clients/dynamodb');
const dynamo = new DynamoDB.DocumentClient();
const middy = require('@middy/core');

const response = require('/opt/nodejs/response');
const debugMiddleware = require('/opt/nodejs/debugger');
const ssmMiddleware = require('/opt/nodejs/ssm');
const errorHandlerMiddleware = require('/opt/nodejs/error-handler');
const eventNormalizerMiddleware = require('/opt/nodejs/api-event-normalizer');

const baseHandler = async event => {
    const { data } = event.normalized;
    const params = {
        TableName: event.table_name,
        Key: {
            id: parseInt(data.id, 10),
        },
        UpdateExpression: 'set #a = :x, #b = :d',
        ExpressionAttributeNames: {
            '#a': 'done',
            '#b': 'updated_at',
        },
        ExpressionAttributeValues: {
            ':x': data.done,
            ':d': new Date().toISOString(),
        },
    };

    await dynamo.update(params).promise();

    console.log({
        message: 'Record has been update',
        data: JSON.stringify(params),
    });

    return response(200, `Record ${data.id} has been updated`);
};

const handler = middy(baseHandler)
    .use(debugMiddleware({ debug: true }))
    .use(eventNormalizerMiddleware())
    .use(ssmMiddleware({ parameterName: process.env.TABLE }))
    .use(errorHandlerMiddleware());

module.exports = { handler };
