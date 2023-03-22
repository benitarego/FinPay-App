const { MongoClient, ObjectId } = require('mongodb');
const env = require('../utils/env');
const users = require('../models/user');

const client = new MongoClient(env.DB_URL);

const dbName = 'cloud';
const collectionNameUsers = 'users';
const collectionNameTxn = 'transactions';

const database = client.db(dbName);
const collectionUser = database.collection(collectionNameUsers);

const collectionTxn = database.collection(collectionNameTxn);

const openConnection = async () => {
    try {
        await client.connect();
        console.log(`Connected to the ${dbName} database.`);
    } catch (err) {
        console.error(`Error Connecting to the database: ${err}`);
    }
};

const closeConnection = async () => {
    try {
        await client.close();
        console.log(`Disconnected from the ${dbName} database.`);
    } catch (err) {
        console.error(`Error closing connection to the database: ${err}`);
    }
};


module.exports = {
    openConnection,
    collectionUser,
    collectionTxn,
    closeConnection,
    ObjectId
};