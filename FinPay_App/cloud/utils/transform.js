module.exports = {
    decodeToken,
    decodeText,
    encodeText,
};

function decodeToken(token) {
    let buff = new Buffer.from(token, 'base64');
    let decoded = buff.toString('ascii');
    let arr = decoded.split(':');
    let user = arr[0];
    let pass = arr[1];
    return { user, pass };
}

function encodeText(inputText) {
    return Buffer.from(inputText, 'utf-8').toString('base64');
}

function decodeText(inputText) {
    return Buffer.from(inputText, 'base64').toString('ascii');
}
