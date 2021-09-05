const normalizeEvent = event => {
    return {
        method: event['requestContext']['http']['method'],
        data: event['body'] ? JSON.parse(event['body']) : {},
        querystring: event['queryStringParameters'] || {},
        pathParameters: event['pathParameters'] || {},
    };
};

module.exports = normalizeEvent;
