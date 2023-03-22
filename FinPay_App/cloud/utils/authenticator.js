const speakeasy = require('speakeasy');
const env = require('./env');

async function get2FACode () {
    console.log('2FA App: ', env.TWO_FACTOR_SECRET);

    const secretCode = speakeasy.generateSecret({
        name: env.TWO_FACTOR_SECRET,
    });

    console.log('Secret Code:');
    console.log(secretCode);

    return {
        otpAuthUrl: secretCode.otpauth_url,
        base32: secretCode.base32,
    };
}

async function verify2FACode (authToken, secretToken) {
    return speakeasy.totp.verify({
        secret: secretToken,
        encoding: 'base32',
        token: authToken,
    });
}

async function createCookie (tokenData) {
    return `Authorization=${tokenData.token}; Http-Only; Max-Age=${tokenData.expiresIn}`;
}

module.exports = {
    get2FACode,
    verify2FACode,
    createCookie,
};
