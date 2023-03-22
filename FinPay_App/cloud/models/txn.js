const mongoose = require('mongoose');
const schema = mongoose.Schema;

let txnSchema = new schema({
    _id: { type: schema.Types.ObjectId },
    gateway: { type: String },
    method: { type: String },
    description: { type: String },
    metadata: { type: Object },
    status: { type: String },
    error_msg: { type: String },
    amount: { type: Number, min: 0.0 },
    currency: { type: String, enum: ['USD', 'INR', 'CAD'] },
    auth_id: { type: schema.Types.ObjectId },
    source_id: { type: schema.Types.ObjectId },
    target_id: { type: schema.Types.ObjectId },
    txn_event: { type: String },
    creation_date: { type: Date, default: Date.now() },
    created_by: { type: String },
});

module.exports = mongoose.model('txn', txnSchema);
