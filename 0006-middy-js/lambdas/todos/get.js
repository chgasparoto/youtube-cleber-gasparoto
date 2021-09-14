const AWS = require('aws-sdk');
const dynamo = new AWS.DynamoDB.DocumentClient();
const middy = require('@middy/core');

const response = require('/opt/nodejs/response');
const debugMiddleware = require('/opt/nodejs/debugger');
const ssmMiddleware = require('/opt/nodejs/ssm');
const errorHandler = require('/opt/nodejs/error-handler');
const normalizeEventMiddleware = require('/opt/nodejs/normalize-api-event');

const baseHandler = async event => {
    let data;
    const {
        pathParameters
    } = event.normalized;
    const params = {
        TableName: event.table_name,
    };

    if (pathParameters && pathParameters['todoId']) {
        data = await dynamo
            .get({
                ...params,
                Key: {
                    id: parseInt(pathParameters['todoId'], 10),
                },
            })
            .promise();
    } else {
        data = await dynamo.scan(params).promise();
    }

    return response(200, data);
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
