const env = require('./env');

module.exports = {
    username: env.DB_USER,
    password: env.DB_PASS,
    dbHigh: env.DB_CONN_HIGH,
    dbMedium: env.DB_CONN_MED,
    dbTxn: env.DB_CONN_TP,
};
