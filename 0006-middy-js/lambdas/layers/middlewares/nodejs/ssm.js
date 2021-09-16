const SSM = require('aws-sdk/clients/ssm');
const ssm = new SSM();

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
