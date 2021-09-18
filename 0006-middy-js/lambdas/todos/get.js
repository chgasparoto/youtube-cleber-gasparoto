const DynamoDB = require('aws-sdk/clients/dynamodb');
const dynamo = new DynamoDB.DocumentClient();
const middy = require('@middy/core');
const httpJsonBodyParser = require('@middy/http-json-body-parser');

const response = require('/opt/nodejs/response');
const debugMiddleware = require('/opt/nodejs/debugger');
const ssmMiddleware = require('/opt/nodejs/ssm');
const errorHandlerMiddleware = require('/opt/nodejs/error-handler');
const eventNormalizerMiddleware = require('/opt/nodejs/api-event-normalizer');

const baseHandler = async event => {
    let data;
    const { pathParameters } = event.normalized;
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

    console.log({
        message: 'Records found',
        data: JSON.stringify(data),
    });

    return response(200, data);
};

const handler = middy(baseHandler)
    .use(debugMiddleware({ debug: true }))
    .use(httpJsonBodyParser())
    .use(eventNormalizerMiddleware())
    .use(ssmMiddleware({ parameterName: process.env.TABLE }))
    .use(errorHandlerMiddleware());

module.exports = { handler };
