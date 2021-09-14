module.exports = () => {
    const normalizeEvent = async (request) => {
        request.event.normalized = {
            method: request.event['requestContext']['http']['method'] || 'GET',
            data: request.event['body'] ? JSON.parse(request.event['body']) : {},
            queryString: request.event['queryStringParameters'] || {},
            pathParameters: request.event['pathParameters'] || {},
        }
    };

    return {
        before: normalizeEvent,
    }
}
