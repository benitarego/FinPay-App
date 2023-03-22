const transform = require('../utils/transform');
const bcrypt = require('bcrypt');
const oci = require('../utils/oci');
const authQ = require('../utils/authenticator');
const QRCode = require('qrcode');
const env = require('../utils/env');

let appStatus = 'STOPPED';

if (env.APP_MODE == 0) {
    // const users = require('../utils/users');
    appStatus = 'STOPPED';
} else {
    appStatus = 'AVAILABLE';
}

const users = require('../utils/mongoFn');
const txn = require('../utils/mongoTxn');

const serverCheck = async (req, res) => {
    res.status(200).send('Server is running!');
};

const saltRounds = 10;

async function registerUser (req, res) {
    let out;
    console.log(appStatus);
    if (appStatus != 'AVAILABLE') {
        out = {
            status: 503,
            message: 'Service Unavailable!',
        };
    } else {
        console.log('Registering user..');

        // console.log(req);
        // console.log(req.body);
        const hashPass = await bcrypt.hash(req.body.user.password, saltRounds);
        console.log(hashPass);
        out = await users.createUser({
            firstName: req.body.user.firstName,
            lastName: req.body.user.lastName,
            username: req.body.user.username,
            password: hashPass,
            email: req.body.user.email,
            mobile: req.body.user.mobile,
            currency: 'USD',
        });
    }
    res.status(out.status).send({ status: out.status, message: out.message });
}

async function loginUser (req, res) {
    const auth = await authentication(req, res);

    if (auth.status == 503) {
        res.setHeader('Retry-After', '10');

        res.status(auth.status).send({
            status: auth.status,
            message: auth.message,
        });
    } else if (auth.status != 200 && auth.status != 503) {
        res.status(auth.status).send({
            status: auth.status,
            message: auth.message,
        });
    } else {
        console.log('User logged in');
        res.send({
            status: 200,
            message: 'Welcome back ' + auth.username + '!!',
            userId: auth.userId,
        });
    }
}

async function getUsers (req, res) {
    const id = req.params._id || req.query.userId;
    const username = req.query.username;
    const email = req.query.email;
    const mobile = req.query.mobile;
    const total = req.query.totalResults || false;
    let resp;

    const auth = await authentication(req, res);

    if (auth.status == 503) {
        res.setHeader('Retry-After', '10');

        res.status(auth.status).send({
            status: auth.status,
            message: auth.message,
        });
    } else if (auth.status != 200 && auth.status != 503) {
        res.status(auth.status).send({
            status: auth.status,
            message: auth.message,
        });
    } else {
        console.log('Searching user based on query');
        if (username || id) {
            const user = {
                username: username,
                _id: id,
            };
            resp = await users.getUser(user);
            if (total) {
                let cnt = Object.keys(resp).length;
                res.status(200).send({
                    status: 200,
                    totalResults: cnt,
                    items: resp,
                });
            } else {
                res.status(200).send({
                    status: 200,
                    items: resp,
                });
            }
        } else {
            resp = await users.getAllUsers();
            if (total) {
                let cnt = Object.keys(resp).length;
                res.status(200).send({
                    totalResults: cnt,
                    status: 200,
                    items: resp,
                });
            } else {
                res.status(200).send({
                    status: 200,
                    items: resp,
                });
            }
        }
    }
}

async function updateUserDetails (req, res) {
    const id = req.params._id;
    const auth = await authentication(req, res);
    if (auth.status == 503) {
        res.setHeader('Retry-After', '10');

        res.status(auth.status).send({
            status: auth.status,
            message: auth.message,
        });
    } else if (auth.status != 200 && auth.status != 503) {
        res.status(auth.status).send({
            status: auth.status,
            message: auth.message,
        });
    } else {
        const user = {
            firstName: req.body.firstName || '#NULL',
            lastName: req.body.lastName || '#NULL',
            email: req.body.email || '#NULL',
            mobile: req.body.mobile || '#NULL',
            _id: id,
            username: auth.username,
        };
        console.log('Updating the user details..');

        const resp = await users.updateUser(user);

        if (resp === null) {
            console.log('User details updated!');
            res.send({
                status: 200,
                message: 'User details updated!',
            });
        } else {
            res.status(500).send({
                status: 500,
                message: resp,
            });
        }
    }
}

async function deleteUserAccount (req, res) {
    const user_id = req.params._id;
    const auth = await authentication(req, res);
    if (auth.status == 503) {
        res.setHeader('Retry-After', '10');

        res.status(auth.status).send({
            status: auth.status,
            message: auth.message,
        });
    } else if (auth.status != 200 && auth.status != 503) {
        res.status(auth.status).send({
            status: auth.status,
            message: auth.message,
        });
    } else if (auth.userId == user_id) {
        console.log('Deleting the user..');
        const resp = await users.deleteUser(user_id);
        if (resp == undefined) {
            console.log('User deleted!');
            res.status(204).send();
        } else {
            res.status(500).send({
                status: 500,
                message: 'Internal server error..',
            });
        }
    } else {
        res.status(403).send({
            status: 403,
            message: 'Invalid Credentials or User Id.',
        });
    }
}

async function enable2FAfn (req, res) {
    const auth = await authentication(req, res);
    if (auth.status == 503) {
        res.setHeader('Retry-After', '10');

        res.status(auth.status).send({
            status: auth.status,
            message: auth.message,
        });
    } else if (auth.status != 200 && auth.status != 503) {
        res.status(auth.status).send({
            status: auth.status,
            message: auth.message,
        });
    } else {
        if (
            req.body.enable2FA === 'Y' &&
            auth.verified === 'Y' &&
            auth.mfaFlag === 'N'
        ) {
            const val = await authQ.get2FACode();
            await users.enableMFA({
                _id: auth.userId,
                token: transform.encodeText(val.base32),
            });
            await QRCode.toFileStream(res, val.otpAuthUrl);
        } else if (req.body.enable2FA !== 'Y' || !req.body.enable2FA) {
            res.status(403).send({
                status: 403,
                message: 'Multi-factor authentication flag is missing!',
            });
        } else if (auth.verified === 'N') {
            res.status(400).send({
                status: 400,
                message: 'Account is not Verified!',
            });
        } else if (auth.mfaFlag === 'Y') {
            res.status(403).send({
                status: 403,
                message: 'Multi-factor Authentication is already activated!',
            });
        }
    }
}

async function verify2FAfn (req, res) {
    const auth = await authentication(req, res);
    if (auth.status == 503) {
        res.setHeader('Retry-After', '10');

        res.status(auth.status).send({
            status: auth.status,
            message: auth.message,
        });
    } else if (auth.status != 200 && auth.status != 503) {
        res.status(auth.status).send({
            status: auth.status,
            message: auth.message,
        });
    } else {
        if (req.body.token) {
            const verified = await authQ.verify2FACode(
                req.body.token,
                transform.decodeText(auth.token)
            );
            console.log('Token Verified: ' + verified);
            res.send({ status: 200, message: null, verified });
        }
    }
}

async function delete2FAfn (req, res) {
    const auth = await authentication(req, res);
    if (auth.status == 503) {
        res.setHeader('Retry-After', '10');

        res.status(auth.status).send({
            status: auth.status,
            message: auth.message,
        });
    } else if (auth.status != 200 && auth.status != 503) {
        res.status(auth.status).send({
            status: auth.status,
            message: auth.message,
        });
    } else {
        if (req.body.token) {
            const verified = await authQ.verify2FACode(
                req.body.token,
                transform.decodeText(auth.token)
            );
            if (verified) {
                const deleted = await users.deleteMFA({ userId: auth.userId });
                if (deleted == undefined) {
                    console.log('MFA deleted!');
                    res.status(204).send();
                } else {
                    res.status(500).send({
                        status: 500,
                        message: 'Internal server error..',
                    });
                }
            } else {
                res.status(403).send({
                    status: 403,
                    message: 'MFA token invalid!',
                });
            }
        }
    }
}

async function userTransaction (req, res) {
    const targetId = req.body.targetId;
    const sourceId = req.body.sourceId;
    const currency = req.body.currency;
    const gateway = req.body.gateway;
    const amount = req.body.amount;
    const method = req.body.method;
    const mode = req.body.mode;
    const desc = req.body.description;
    const sourceUser = req.body.sourceUser;
    const targetUser = req.body.targetUser;

    const auth = await authentication(req, res);

    const txnObj = {
        targetId,
        sourceId,
        currency,
        gateway,
        amount,
        method,
        mode,
        desc,
        sourceUser,
        targetUser
    };

    if (auth.status == 503) {
        res.setHeader('Retry-After', '10');

        res.status(auth.status).send({
            status: auth.status,
            message: auth.message,
        });
    } else if (auth.status != 200 && auth.status != 503) {
        res.status(auth.status).send({
            status: auth.status,
            message: auth.message,
        });
    } else if (
        !currency ||
        !gateway ||
        !amount ||
        !method ||
        !mode ||
        !sourceUser ||
        !targetUser
    ) {
        res.status(400).send({
            status: 400,
            message:
                'Mandatory objects not provided to complete the transaction.',
        });
    } else if (
        mode.toUpperCase() == 'DEPOSIT' ||
        mode.toUpperCase() == 'WITHDRAW' ||
        mode.toUpperCase() == 'P2P'
    ) {
        console.log('Amount transfer in progress..');
        //console.log(txnObj);
        const resp = await txn.loadMoney(txnObj);

        if (resp === null) {
            console.log('Amount transfer successful!');
            res.send({
                status: 200,
                message: 'Amount transfer successful!',
            });
        } else {
            console.log('ERROR: ' + resp.message);
            res.status(resp.status).send({
                status: resp.status,
                message: resp.message,
            });
        }
    } else {
        res.status(403).send({
            status: 403,
            message:
                "Invalid value provided for identifier 'Mode'. " +
                'Valid values are DEPOSIT, WITHDRAW, P2P.',
        });
    }
}

async function checkUser (user, pass) {
    console.log('search using user credentials');
    const resp = await users.searchUserAccount(user);
    console.log(resp);

    if (resp != null) {
        const hashPass = resp.password;
        const validUser = await bcrypt.compare(pass, hashPass);

        if (validUser) {
            return {
                userId: resp._id,
                firstName: resp.firstName,
                username: resp.username,
                password: validUser,
                mfaFlag: resp.mfa,
                token: resp.token,
                verified: resp.verified,
            };
        }
    }
    return {
        userId: 0,
        firstName: null,
        username: null,
        password: null,
        mfaFlag: null,
        token: '',
        verified: null,
    };
}

async function authentication (req, res) {
    console.log(appStatus);
    if (appStatus != 'AVAILABLE') {
        return {
            status: 503,
            message: 'Service Unavailable!',
        };
    } else if (!req.headers.authorization) {
        console.log('No token. User authentication failed!');
        return {
            status: 401,
            message: 'Authentication failed. Please provide a Token!',
        };
    } else {
        const encoded = req.headers.authorization.replace('Basic ', '');
        const auth = transform.decodeToken(encoded);
        const authCred = await checkUser(auth.user, auth.pass);
        let secretCode;
        if (secretCode === null) {
            secretCode = 'XXXXXX';
        } else {
            secretCode = transform.decodeText(authCred.token);
        }
        const userToken = await authQ.verify2FACode(req.body.token, secretCode);
        if (
            authCred.userId == 0 ||
            auth.user !== authCred.username ||
            !authCred.password
        ) {
            console.log('User authentication failed!');
            return {
                status: 401,
                message:
                    'Authentication failed. Invalid Username or Password!!',
            };
        } else if (authCred.mfaFlag === 'Y' && !userToken) {
            return {
                status: 401,
                message: 'Authentication failed. Invalid MFA Token!!',
            };
        } else if (authCred.mfaFlag === 'Y' && userToken) {
            console.log('User Authenticated with 2FA');
            return {
                status: 200,
                message: 'User Authenticated.',
                userId: authCred.userId,
                username: authCred.username,
                mfaFlag: authCred.mfaFlag,
                token: authCred.token,
                verified: authCred.verified,
            };
        } else if (auth.user === authCred.username && authCred.password) {
            console.log('User Authenticated without 2FA');
            return {
                status: 200,
                message: 'User Authenticated.',
                userId: authCred.userId,
                username: authCred.username,
                mfaFlag: authCred.mfaFlag,
                token: authCred.token,
                verified: authCred.verified,
            };
        }
    }
}

async function getAppStatus () {
    appStatus = await oci.initializeOCI();
}

module.exports = {
    registerUser,
    loginUser,
    getUsers,
    updateUserDetails,
    deleteUserAccount,
    userTransaction,
    getAppStatus,
    enable2FAfn,
    verify2FAfn,
    delete2FAfn,
    serverCheck,
};
