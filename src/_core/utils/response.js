const build = (statusCode, body) => ({
    headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': true
    },
    statusCode,
    body: JSON.stringify(body)
});

const buildText = (statusCode, body) => ({
    headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': true
    },
    statusCode,
    body
});

const text = body => buildText(200, body);
const success = body => build(200, body);
const businessRuleError = body => build(400, body);
const notFound = body => build(404, body);
const failure = body => build(500, body);
const badData = () => build(422, {
    error: 'Unprocessable Entity',
    message: 'your data is bad and you should feel bad'
});

export {
    build,
    success,
    text,
    businessRuleError,
    notFound,
    badData,
    failure
};