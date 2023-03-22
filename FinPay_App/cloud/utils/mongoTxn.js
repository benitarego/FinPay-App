const mongo = require('./mongo');

const collectionTxn = mongo.collectionTxn;
const collectionUser = mongo.collectionUser;

const loadMoney = async (txnObj) => {
    let sourceQry = { username: txnObj.sourceUser };
    let targetQry = { username: txnObj.targetUser };
    let response;

    if (txnObj.mode.toUpperCase() === 'DEPOSIT') {
        if (txnObj.amount < 25.00 || txnObj.amount < 0) {

            collectionTxn.insertOne({
                gateway: 'FinPay',
                method: 'default',
                description: null,
                metadata: {},
                status: 'E',
                error_msg: `The minimum deposit is ${txnObj.currency} 25!`,
                amount: txnObj.amount,
                currency: txnObj.currency,
                auth_id: null,
                source_id: txnObj.sourceUser,
                target_id: txnObj.targetUser,
                txn_event: 'DEPOSIT',
                creation_date: new Date(),
                created_by: txnObj.sourceUser
            });

            return response = {
                status: 400,
                message: `The minimum deposit amount is ${txnObj.currency} 25!`,
            };
        }

        try {
            let sourceUser = await collectionUser.findOne(sourceQry);

            console.log('Printing user', sourceUser);

            let result = await collectionUser.updateOne(
                sourceQry,
                { $set: { 'balance': sourceUser.balance + txnObj.amount } }
            );
            console.log('Inside Deposit update..');

            console.log(result);
            if (result.modifiedCount === 1) {

                collectionTxn.insertOne({
                    gateway: 'FinPay',
                    method: 'default',
                    description: null,
                    metadata: {},
                    status: 'S',
                    error_msg: null,
                    amount: txnObj.amount,
                    currency: txnObj.currency,
                    auth_id: null,
                    source_id: txnObj.sourceUser,
                    target_id: txnObj.targetUser,
                    txn_event: 'DEPOSIT',
                    creation_date: new Date(),
                    created_by: txnObj.sourceUser
                });

                return null;
            } else {
                throw new Error('Error: User not found!');
            }


        } catch (err) {
            console.error(err, err.message);
            collectionTxn.insertOne({
                gateway: 'FinPay',
                method: 'default',
                description: null,
                metadata: {},
                status: 'E',
                error_msg: err.message,
                amount: txnObj.amount,
                currency: txnObj.currency,
                auth_id: null,
                source_id: txnObj.sourceUser,
                target_id: txnObj.targetUser,
                txn_event: 'DEPOSIT',
                creation_date: new Date(),
                created_by: txnObj.sourceUser
            });

            return err;
        }
    } else if (txnObj.mode.toUpperCase() === 'WITHDRAW') {
        let sourceUser;

        try {
            sourceUser = await collectionUser.findOne(sourceQry);
        } catch (err) {
            console.error(err, err.message);
            return err;
        }

        if (txnObj.amount > sourceUser.balance || txnObj.amount < 0) {

            collectionTxn.insertOne({
                gateway: 'FinPay',
                method: 'default',
                description: null,
                metadata: {},
                status: 'E',
                error_msg: `Insufficient Balance or Invalid Amount!!`,
                amount: txnObj.amount,
                currency: txnObj.currency,
                auth_id: null,
                source_id: txnObj.sourceUser,
                target_id: txnObj.targetUser,
                txn_event: 'WITHDRAW',
                creation_date: new Date(),
                created_by: txnObj.sourceUser
            });

            return response = {
                status: 400,
                message: `Insufficient Balance or Invalid Amount!`,
            };
        }

        try {
            let result = await collectionUser.updateOne(
                sourceQry,
                { $set: { 'balance': sourceUser.balance - txnObj.amount } }
            );

            if (result.modifiedCount > 0) {
                collectionTxn.insertOne({
                    gateway: 'FinPay',
                    method: 'default',
                    description: null,
                    metadata: {},
                    status: 'S',
                    error_msg: null,
                    amount: txnObj.amount,
                    currency: txnObj.currency,
                    auth_id: null,
                    source_id: txnObj.sourceUser,
                    target_id: txnObj.targetUser,
                    txn_event: 'WITHDRAW',
                    creation_date: new Date(),
                    created_by: txnObj.sourceUser
                });

                return null;

            } else {
                throw new Error('Error: Withdrawal transaction failed!');
            }


        } catch (err) {
            console.error(err, err.message);
            collectionTxn.insertOne({
                gateway: 'FinPay',
                method: 'default',
                description: null,
                metadata: {},
                status: 'E',
                error_msg: err.message,
                amount: txnObj.amount,
                currency: txnObj.currency,
                auth_id: null,
                source_id: txnObj.sourceUser,
                target_id: txnObj.targetUser,
                txn_event: 'WITHDRAW',
                creation_date: new Date(),
                created_by: txnObj.sourceUser
            });

            return err;
        }
    } else if (txnObj.mode.toUpperCase() === 'P2P') {
        let sourceUser;
        let targetUser;

        try {
            sourceUser = await collectionUser.findOne(sourceQry);
            targetUser = await collectionUser.findOne(targetQry);
        } catch (err) {
            console.error(err, err.message);
            return err;
        }

        if (txnObj.amount > sourceUser.balance || txnObj.amount < 0) {

            collectionTxn.insertOne({
                gateway: 'FinPay',
                method: 'default',
                description: null,
                metadata: {},
                status: 'E',
                error_msg: `Insufficient Balance or Invalid Amount in Source!`,
                amount: txnObj.amount,
                currency: txnObj.currency,
                auth_id: null,
                source_id: txnObj.sourceUser,
                target_id: txnObj.targetUser,
                txn_event: 'P2P',
                creation_date: new Date(),
                created_by: txnObj.sourceUser
            });

            return response = {
                status: 400,
                message: `Insufficient Balance or Invalid Amount!`,
            };
        }

        try {
            let source = await collectionUser.updateOne(
                sourceQry,
                { $set: { 'balance': sourceUser.balance - txnObj.amount } }
            );

            let target = await collectionUser.updateOne(
                targetQry,
                { $set: { 'balance': targetUser.balance + txnObj.amount } }
            );

            if (source.modifiedCount > 0 && target.modifiedCount > 0) {
                collectionTxn.insertOne({
                    gateway: 'FinPay',
                    method: 'default',
                    description: null,
                    metadata: {},
                    status: 'S',
                    error_msg: null,
                    amount: txnObj.amount,
                    currency: txnObj.currency,
                    auth_id: null,
                    source_id: txnObj.sourceUser,
                    target_id: txnObj.targetUser,
                    txn_event: 'P2P',
                    creation_date: new Date(),
                    created_by: txnObj.sourceUser
                });

                return null;
            } else if (source.matchedCount === 0 || target.modifiedCount == 0) {
                throw new Error('Error: P2P Transaction failed!');
            }

        } catch (err) {
            console.error(err, err.message);
            collectionTxn.insertOne({
                gateway: 'FinPay',
                method: 'default',
                description: null,
                metadata: {},
                status: 'E',
                error_msg: err.message,
                amount: txnObj.amount,
                currency: txnObj.currency,
                auth_id: null,
                source_id: txnObj.sourceUser,
                target_id: txnObj.targetUser,
                txn_event: 'P2P',
                creation_date: new Date(),
                created_by: txnObj.sourceUser
            });

            return err;
        }
    }

};

module.exports = {
    loadMoney
};