const db = require('./connection');

async function loadMoney(txnObj) {
    let result;
    let pool;
    const poolStatus = await db.checkPoolStatus();
    if (poolStatus === db.poolStatus.poolClosed) {
        pool = await db.openPool();
    } else {
        pool = db.getPool();
    }

    const sql = `BEGIN
                    XXFIN_USER_TXN  ( :srcId, :tarId, :txnCur, :txnAmt, :txnMethod
                                    , :txnGate, :txnMode, :txnDesc, :error_msg);
                END;`;

    const bind = {
        srcId: {
            dir: db.oracledb.BIND_IN,
            type: db.oracledb.DB_TYPE_NUMBER,
            val: txnObj.sourceId,
        },
        tarId: {
            dir: db.oracledb.BIND_IN,
            type: db.oracledb.DB_TYPE_NUMBER,
            val: txnObj.targetId,
        },
        txnCur: {
            dir: db.oracledb.BIND_IN,
            val: txnObj.currency,
        },
        txnAmt: {
            dir: db.oracledb.BIND_IN,
            type: db.oracledb.DB_TYPE_NUMBER,
            val: txnObj.amount,
        },
        txnMethod: {
            dir: db.oracledb.BIND_IN,
            val: txnObj.method,
        },
        txnGate: {
            dir: db.oracledb.BIND_IN,
            val: txnObj.gateway,
        },
        txnMode: {
            dir: db.oracledb.BIND_IN,
            val: txnObj.mode,
        },
        txnDesc: {
            dir: db.oracledb.BIND_IN,
            val: txnObj.desc,
        },
        error_msg: { dir: db.oracledb.BIND_OUT },
    };

    try {
        result = await db.openConnection(pool, sql, bind);
        return result.outBinds.error_msg;
    } catch (err) {
        console.log(err, err.message);
        return err;
    }
}

module.exports = {
    loadMoney,
};
