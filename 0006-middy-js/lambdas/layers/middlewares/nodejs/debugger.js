const defaults = {
    debug: true
}

module.exports = (opts = {}) => {
    const options = { ...defaults, ...opts }

    const debugEvent = async (request) => {
        if (process.env.DEBUG && options.debug) {
            console.log({
                message: 'Received event',
                data: JSON.stringify(request.event),
            });
        }
    }

    return {
        before: debugEvent,
    }
}
