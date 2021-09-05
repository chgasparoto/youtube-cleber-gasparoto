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
        const {
            data: { id },
        } = normalizeEvent(event);

        const params = {
            TableName: table,
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
    } catch (err) {
        console.error(err);
        return response(500, 'Somenthing went wrong');
    }
};
