const db = require('./connection');

async function createUser(newUser) {
    let result;
    let pool;
    const poolStatus = await db.checkPoolStatus();
    if (poolStatus === db.poolStatus.poolClosed) {
        pool = await db.openPool();
    } else {
        pool = db.getPool();
    }

    const sql = `INSERT INTO XXFIN_USERS ( first_name
                                         , last_name
                                         , email
                                         , mobile
                                         , username
                                         , password
                                         , currency
                                         , creation_date
                                         , last_updated_date) 
                                    VALUES  ( TRIM(:v_fname)
                                            , TRIM(:v_lname)
                                            , TRIM(:v_email)
                                            , TRIM(:v_mobile)
                                            , TRIM(:v_user)
                                            , TRIM(:v_pass)
                                            , TRIM(:v_currency)
                                            , SYSDATE
                                            , SYSDATE)`;
    const bind = [
        newUser.firstName,
        newUser.lastName,
        newUser.email,
        newUser.mobile,
        newUser.username,
        newUser.password,
        newUser.currency,
    ];

    const logObj = {
        objectId: null,
        objectName: null,
        loggingEvent: null,
        description: null,
    };

    try {
        result = await db.openConnection(pool, sql, bind);
        if (result.rowsAffected == 1) {
            return {
                status: 201,
                message: 'User Created!!',
            };
        }
    } catch (err) {
        let response, userMsg, emailMsg, mobileMsg;
        console.error('print err', err, err.message);
        userMsg = err.message.includes('USERNAME');
        emailMsg = err.message.includes('EMAIL');
        mobileMsg = err.message.includes('MOBILE');
        accMsg = err.message.includes('ACCOUNT');
        if (err.errorNum == 1 && userMsg) {
            response = {
                status: 202,
                message:
                    'An account already exists with these details! ' +
                    'Kindly use a different username,',
            };
        } else if (err.errorNum == 1 && emailMsg) {
            response = {
                status: 202,
                message:
                    'An account already exists with these details! ' +
                    'Kindly use a different email id,',
            };
        } else if (err.errorNum == 1 && mobileMsg) {
            response = {
                status: 202,
                message:
                    'An account already exists with these details! ' +
                    'Kindly use a different mobile no,',
            };
        } else {
            response = {
                status: 400,
                message: err.message,
            };
        }
        return response;
    }
}

async function getAllUsers() {
    let result;
    let pool;
    const poolStatus = await db.checkPoolStatus();
    if (poolStatus === db.poolStatus.poolClosed) {
        pool = await db.openPool();
    } else {
        pool = db.getPool();
    }

    const sql = `SELECT XFU.first_name
                      , XFU.last_name
                      , XFU.username
                      , XFU.email
                      , XFU.mobile
                      , XFU.verified
                      , XFU.mobile_verified
                      , XFU.email_verified
                      , TO_CHAR(XFU.creation_date, 'Mon-YYYY', 'NLS_DATE_LANGUAGE=ENGLISH') MEMBER_SINCE
                      , TO_CHAR(XFU.last_updated_date, 'DD-Mon-YYYY', 'NLS_DATE_LANGUAGE=ENGLISH') LAST_UPDATE
                   FROM xxfin_users XFU
                  ORDER BY TRUNC(XFU.creation_date) DESC`;
    const bind = [];

    try {
        result = await db.openConnection(pool, sql, bind);
        return result.rows;
    } catch (err) {
        console.error(err, err.message);
        return err;
    }
}

async function getUser(user) {
    let result;
    let pool;
    const poolStatus = await db.checkPoolStatus();
    if (poolStatus === db.poolStatus.poolClosed) {
        pool = await db.openPool();
    } else {
        pool = db.getPool();
    }

    const sql = `SELECT XFU.user_id
                      , XFU.first_name
                      , XFU.last_name
                      , XFU.username
                      , XFU.email
                      , XFU.mobile
                      , XFU.verified
                      , XFU.mobile_verified
                      , XFU.email_verified
                      , TO_CHAR(XFU.creation_date, 'Mon-YYYY', 'NLS_DATE_LANGUAGE=ENGLISH') MEMBER_SINCE
                      , TO_CHAR(XFU.last_updated_date, 'DD-Mon-YYYY', 'NLS_DATE_LANGUAGE=ENGLISH') LAST_UPDATE
                   FROM xxfin_users XFU
                  WHERE (   XFU.user_id = TRIM(:1) 
                         OR UPPER(XFU.username) = UPPER(TRIM(:2))
                         OR UPPER(XFU.email) = UPPER(TRIM(:3))
                         OR XFU.mobile = TRIM(:4)
                        )`;
    const bind = [user.id, user.username, user.email, user.mobile];

    try {
        result = await db.openConnection(pool, sql, bind);
        return result.rows;
    } catch (err) {
        console.error(err, err.message);
        return err;
    }
}

async function searchUserAccount(username) {
    let result;
    let pool;
    const poolStatus = await db.checkPoolStatus();
    if (poolStatus === db.poolStatus.poolClosed) {
        pool = await db.openPool();
    } else {
        pool = db.getPool();
    }

    const sql = `SELECT XFU.user_id
                      , XFU.first_name
                      , XFU.username
                      , XFU.password
                      , XFU.mfa
                      , XFU.token
                      , XFU.verified
                   FROM xxfin_users XFU
                  WHERE UPPER(XFU.username) = UPPER(TRIM(:1))`;
    const bind = [username];

    try {
        result = await db.openConnection(pool, sql, bind);
        return result.rows;
    } catch (err) {
        console.log(err, err.message);
        return err;
    }
}

async function deleteUser(id) {
    let result;
    let pool;
    const poolStatus = await db.checkPoolStatus();
    if (poolStatus === db.poolStatus.poolClosed) {
        pool = await db.openPool();
    } else {
        pool = db.getPool();
    }

    const sql = `DELETE FROM xxfin_users XFU WHERE XFU.user_id = TRIM(:1)`;
    const bind = [id];

    try {
        result = await db.openConnection(pool, sql, bind);
        return result.rows;
    } catch (err) {
        console.log(err, err.message);
        return err;
    }
}

async function updateUser(user) {
    let result;
    let pool;
    const poolStatus = await db.checkPoolStatus();
    if (poolStatus === db.poolStatus.poolClosed) {
        pool = await db.openPool();
    } else {
        pool = db.getPool();
    }

    const sql = `BEGIN 
                    XXFIN_UPDATE_USER(:fname, :lname, :email, :mobile, :userId, :ids, :error_msg);
                END;`;

    const bind = {
        fname: {
            dir: db.oracledb.BIND_IN,
            val: user.firstName,
        },
        lname: {
            dir: db.oracledb.BIND_IN,
            val: user.lastName,
        },
        email: {
            dir: db.oracledb.BIND_IN,
            val: user.email,
        },
        mobile: {
            dir: db.oracledb.BIND_IN,
            val: user.mobile,
        },
        userId: {
            dir: db.oracledb.BIND_IN,
            val: user.id,
        },
        ids: { dir: db.oracledb.BIND_OUT },
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

async function enableMFA(user) {
    let result;
    let pool;
    const poolStatus = await db.checkPoolStatus();
    if (poolStatus === db.poolStatus.poolClosed) {
        pool = await db.openPool();
    } else {
        pool = db.getPool();
    }
    console.log(user);

    const sql = `UPDATE xxfin_users XFU 
                    SET XFU.mfa = 'Y'
                      , XFU.token = :1
                      , XFU.last_updated_date = SYSDATE
                  WHERE XFU.user_id = :2`;

    const bind = [user.token, user.userId];

    try {
        result = await db.openConnection(pool, sql, bind);
        return result.rows;
    } catch (err) {
        console.log(err, err.message);
        return err;
    }
}

async function deleteMFA(user) {
    let result;
    let pool;
    const poolStatus = await db.checkPoolStatus();
    if (poolStatus === db.poolStatus.poolClosed) {
        pool = await db.openPool();
    } else {
        pool = db.getPool();
    }
    console.log(user);

    const sql = `UPDATE xxfin_users XFU 
                    SET XFU.mfa = 'N'
                      , XFU.token = NULL
                      , XFU.last_updated_date = SYSDATE
                  WHERE XFU.user_id = :1`;

    const bind = [user.userId];

    try {
        result = await db.openConnection(pool, sql, bind);
        return result.rows;
    } catch (err) {
        console.log(err, err.message);
        return err;
    }
}

module.exports = {
    createUser,
    getAllUsers,
    getUser,
    searchUserAccount,
    deleteUser,
    updateUser,
    enableMFA,
    deleteMFA,
};
