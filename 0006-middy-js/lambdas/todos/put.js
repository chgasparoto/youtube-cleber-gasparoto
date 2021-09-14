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
        data
    } = event.normalized;
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
    .use(debugMiddleware())
    .use(normalizeEventMiddleware())
    .use(ssmMiddleware({
        parameterName: process.env.TABLE
    }))
    .use(errorHandler());

module.exports = {
    handler
};
