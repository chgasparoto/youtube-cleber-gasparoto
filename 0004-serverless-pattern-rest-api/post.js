const AWS = require('aws-sdk');
const dynamo = new AWS.DynamoDB.DocumentClient();

const normalizeEvent = require('./normalizer');
const response = require('./response');

exports.handler = async event => {
    if (process.env.DEBUG) {
        console.log({
            message: 'Received event',
            data: JSON.stringify(event),
        });
    }

    const table = event.table || process.env.TABLE;
    if (!table) {
        throw new Error('No table name defined.');
    }

    const { data } = normalizeEvent(event);

    const params = {
        TableName: table,
        Item: {
            ...data,
            created_at: new Date().toISOString(),
        },
    };

    try {
        await dynamo.put(params).promise();

        console.log({
            message: 'Record has been created',
            data: JSON.stringify(params),
        });

        return response(201, `Record ${data.id} has been created`);
    } catch (err) {
        console.error(err);
        return response(500, 'Somenthing went wrong');
    }
};
