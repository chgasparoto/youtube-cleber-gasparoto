module.exports = () => {
    const errorHandler = async (request) => {
        console.error(request.error || '');
        return {
            statusCode: 500,
            body: 'Something went wrong',
            headers: {
                'Content-Type': 'application/json',
            },
        };
    };

    return {
        onError: errorHandler,
    }
}
