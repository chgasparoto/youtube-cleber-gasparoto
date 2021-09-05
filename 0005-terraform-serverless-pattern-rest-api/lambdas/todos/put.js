const AWS = require('aws-sdk');
const dynamo = new AWS.DynamoDB.DocumentClient();
const ssm = new AWS.SSM();

const normalizeEvent = require('/opt/nodejs/normalizer');
const response = require('/opt/nodejs/response');

exports.handler = async event => {
    if (process.env.DEBUG) {
        console.log({
            message: 'Received event',
            data: JSON.stringify(event),
        });
    }

    try {
        const { Parameter: { Value: table } } = await ssm.getParameter({ Name: process.env.TABLE }).promise();
        const { data } = normalizeEvent(event);
        const params = {
            TableName: table,
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
    } catch (err) {
        console.error(err);
        return response(500, 'Somenthing went wrong');
    }
};
