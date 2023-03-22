const { common, database } = require('oci-sdk');
const db = require('../utils/connection');
const env = require('./env');

const configurationFilePath = env.CONFIG_FILE_PATH;
const dbId = env.ADB_OCID;

let provider;

async function loadConfigFile() {
    try {
        provider = new common.ConfigFileAuthenticationDetailsProvider(
            configurationFilePath
        );
        console.log('OCI Provider running...');
    } catch (error) {
        console.log('Error in Calling config: ' + error);
    }
}

async function checkADBStatus() {
    try {
        const databaseClient = new database.DatabaseClient({
            authenticationDetailsProvider: provider,
        });

        const databaseRequest = await databaseClient.getAutonomousDatabase({
            autonomousDatabaseId: dbId,
        });

        return databaseRequest.autonomousDatabase.lifecycleState;
    } catch (err) {
        console.log('Get Autonomous DB error: ' + err);
    }
}

async function initializeOCI() {
    let dbStatus = await checkADBStatus();
    console.log('ADB Status = ' + dbStatus);

    if (dbStatus == 'AVAILABLE') {
        await db.initializeDB();
        await db.openPool();
        console.log('DB is available');
        return dbStatus;
    } else if (dbStatus == 'STOPPED') {
        console.log('DB is not available!');
        dbStatus = await startADB();
    }
    setTimeout(() => {
        initializeOCI();
    }, 7500);
}

async function startADB() {
    console.log('Starting Autonomous DB...');
    try {
        const databaseClient = new database.DatabaseClient({
            authenticationDetailsProvider: provider,
        });

        const databaseRequest = await databaseClient.startAutonomousDatabase({
            autonomousDatabaseId: dbId,
        });

        return databaseRequest.autonomousDatabase.lifecycleState;
    } catch (err) {
        console.log('Start Autonomous DB error: ' + err);
    }
}

module.exports = {
    initializeOCI,
    loadConfigFile,
};
