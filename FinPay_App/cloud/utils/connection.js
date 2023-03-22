const oracledb = require('oracledb');
const dbConfig = require('./dbConfig');

oracledb.outFormat = oracledb.OUT_FORMAT_OBJECT;

let libPath;
const poolNameDef = 'default';
const poolSts = {
    poolClosed: oracledb.POOL_STATUS_CLOSED,
    poolOpen: oracledb.POOL_STATUS_OPEN,
    poolDraining: oracledb.POOL_STATUS_DRAINING,
};

if (process.platform == 'win32') {
    libPath = 'C:\\Program Files\\Oracle\\instantclient_21_3';
}

async function initDB() {
    try {
        oracledb.initOracleClient({
            libDir: libPath,
        });
        oracledb.version;

        console.log('Client activated');
    } catch (err) {
        console.error('Whoops!');
        console.error(err);
        process.exit(1);
    }
}

async function openPool() {
    try {
        const pool = await oracledb.createPool({
            user: dbConfig.username,
            password: dbConfig.password,
            connectString: dbConfig.dbTxn,
            poolAlias: poolNameDef,
            poolMax: 10,
            poolMin: 10,
            poolIncrement: 0,
        });
        console.log('Connection pool started for ' + poolNameDef);

        return pool;
    } catch (err) {
        console.error('init() error: ' + err.message);
    }
}

async function openConnection(pool, Query, bindOpts) {
    let connection, sql, binds, result;

    console.log('Connection started');
    try {
        connection = await pool.getConnection();
        if (Query == null) {
            sql = `SELECT sysdate FROM dual`;
            binds = [];
        } else {
            sql = Query;
            binds = bindOpts;
        }
        result = await connection.execute(sql, binds);
        //console.log(result);
        return result;
    } catch (err) {
        throw err;
    } finally {
        if (connection) {
            try {
                await connection.commit();
                console.log('Releasing connection');
                await connection.close();
            } catch (err) {
                throw err;
            }
        }
    }
}

async function closePool(pool) {
    try {
        console.log('Closing Pool ' + poolNameDef);
        await pool.close(10);
    } catch (err) {
        console.error(err.message);
        process.exit(1);
    } finally {
        console.log('\nTerminating...');
        process.exit(0);
    }
}

async function checkPoolStatus() {
    return oracledb.getPool(poolNameDef).status;
}

function getPool() {
    return oracledb.getPool(poolNameDef);
}

module.exports = {
    initializeDB: initDB,
    checkPoolStatus: checkPoolStatus,
    openPool: openPool,
    getPool: getPool,
    closePool: closePool,
    openConnection: openConnection,
    poolStatus: poolSts,
    oracledb: oracledb,
};
