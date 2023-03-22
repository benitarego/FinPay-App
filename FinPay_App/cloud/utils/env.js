const os = require('os');

if (os.platform == 'win32') {
    const dotenv = require('dotenv').config();
}

module.exports = {
    PORT: process.env.PORT || 3005,
    TWO_FACTOR_SECRET: process.env.TWO_FACTOR_SECRET,
    CONFIG_FILE_PATH: process.env.CONFIG_FILE_PATH,
    ADB_OCID: process.env.ADB_OCID,
    DB_USER: process.env.DB_USER,
    DB_PASS: process.env.DB_PASS,
    DB_CONN_HIGH: process.env.DB_CONN_HIGH,
    DB_CONN_MED: process.env.DB_CONN_MED,
    DB_CONN_TP: process.env.DB_CONN_TP,
    APP_MODE: process.env.APP_MODE || 1,
    DB_URL: process.env.DB_URL,
};
