const got = require('got');

exports.handler = async (event, context) => {
    try {
        const response = await got('https://aws.random.cat/meow');
        console.log(response.body);
    } catch (error) {
        console.log(error.response.body);
    }
}
