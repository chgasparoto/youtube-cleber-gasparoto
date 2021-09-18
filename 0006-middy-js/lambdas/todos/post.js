const DynamoDB = require('aws-sdk/clients/dynamodb');
const dynamo = new DynamoDB.DocumentClient();
const middy = require('@middy/core');

const response = require('/opt/nodejs/response');
const debugMiddleware = require('/opt/nodejs/debugger');
const ssmMiddleware = require('/opt/nodejs/ssm');
const errorHandlerMiddleware = require('/opt/nodejs/error-handler');
const eventNormalizerMiddleware = require('/opt/nodejs/api-event-normalizer');

const baseHandler = async event => {
    const {
        data
    } = event.normalized;

    const params = {
        TableName: event.table_name,
        Item: {
            ...data,
            created_at: new Date().toISOString(),
        },
    };

    await dynamo.put(params).promise();

    console.log({
        message: 'Record has been created',
        data: JSON.stringify(params),
    });

    return response(201, `Record ${data.id} has been created`);
};

const handler = middy(baseHandler)
    .use(debugMiddleware({ debug: true }))
    .use(eventNormalizerMiddleware())
    .use(ssmMiddleware({ parameterName: process.env.TABLE }))
    .use(errorHandlerMiddleware());

module.exports = { handler };
