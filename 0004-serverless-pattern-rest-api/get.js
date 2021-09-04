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

    const { pathParameters } = normalizeEvent(event);

    const params = {
        TableName: table,
    };

    try {
        let data = {};
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
    } catch (err) {
        console.error(err);
        return response(500, 'Somenthing went wrong');
    }
};
