module.exports = () => {

    const eventNormalizer = async (request) => {
        request.event.normalized = {
            method: request.event['requestContext']['http']['method'] || 'GET',
            data: request.event['body'] ? JSON.parse(request.event['body']) : {},
            querystring: request.event['queryStringParameters'] || {},
            pathParameters: request.event['pathParameters'] || {},
        }
    }

    return {
        before: eventNormalizer,
    }
}
