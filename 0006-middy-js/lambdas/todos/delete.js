const AWS = require('aws-sdk');
const dynamo = new AWS.DynamoDB.DocumentClient();
const middy = require('@middy/core');

const response = require('/opt/nodejs/response');
const debugMiddleware = require('/opt/nodejs/debugger');
const ssmMiddleware = require('/opt/nodejs/ssm');
const errorHandler = require('/opt/nodejs/error-handler');
const normalizeEventMiddleware = require('/opt/nodejs/normalize-api-event');

const baseHandler = async event => {
    const {
        data: {
            id
        }
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
    .use(debugMiddleware())
    .use(normalizeEventMiddleware())
    .use(ssmMiddleware({
        parameterName: process.env.TABLE
    }))
    .use(errorHandler());

module.exports = {
    handler
};
