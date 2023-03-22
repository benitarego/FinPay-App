const express = require('express');
const fn = require('./fn');
const oci = require('../utils/oci');
const rateLimit = require('express-rate-limit');
const env = require('../utils/env');
const mongo = require('../utils/mongo');
const mongoFn = require('../utils/mongoFn');

const limiter = rateLimit({
    windowMs: 1 * 60 * 1000, // 1 minute
    max: 5,
});

const app = express();
const port = env.PORT;

// apply rate limiter to all requests
app.use(limiter);

// TODO: Log events of login, signup, and delete user

const mode = env.APP_MODE;

app.use(express.urlencoded({ extended: true }));
app.use(express.json());

app.set('title', 'FinPay Server');

app.post('/api/users/register', fn.registerUser);
app.post('/api/users/login', fn.loginUser);
app.post('/api/users/mfa', fn.enable2FAfn);
app.post('/api/users/verify', fn.verify2FAfn);

app.patch('/api/users/:id', fn.updateUserDetails);

app.delete('/api/users/mfa', fn.delete2FAfn);
app.delete('/api/users/:id', fn.deleteUserAccount);

app.get('/api/users/:id', fn.getUsers);
app.get('/api/users', fn.getUsers);

app.post('/api/txn/exchange', fn.userTransaction);

// Server up check
app.get('/api', fn.serverCheck);


app.all('*', (req, res) => {
    res.status(405).send({ status: 405, message: 'Method not allowed' });
});

app.listen(port, async () => {
    console.log('Server running on port: ' + port);
    console.log('App Mode: ' + mode);

    if (mode === 0) {
        await oci.loadConfigFile();
        fn.getAppStatus();
    } else {
        mongo.openConnection();
    }
});
