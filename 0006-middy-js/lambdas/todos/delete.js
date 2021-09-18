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
        data: { id },
    } = event.normalized;

    const params = {
        TableName: event.table_name,
        Key: {
            id: parseInt(id, 10),
        },
    };

    await dynamo.delete(params).promise();

    console.log({
        message: 'Record has been deleted',
        data: JSON.stringify(params),
    });

    return response(200, `Record ${id} has been deleted`);
};

const handler = middy(baseHandler)
    .use(debugMiddleware({ debug: true }))
    .use(eventNormalizerMiddleware())
    .use(ssmMiddleware({ parameterName: process.env.TABLE }))
    .use(errorHandlerMiddleware());

module.exports = { handler };
