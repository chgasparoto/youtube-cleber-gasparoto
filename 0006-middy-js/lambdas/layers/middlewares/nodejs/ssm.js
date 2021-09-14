const AWS = require('aws-sdk');
const ssm = new AWS.SSM();

const defaults = {}

module.exports = (opts = {}) => {
    const options = { ...defaults, ...opts }

    const getParameter = async (request) => {
        const { Parameter: { Value } } = await ssm.getParameter({ Name: options.parameterName }).promise();
        request.event.table_name = Value;
    };

    return {
        before: getParameter,
    }
}
