const mongoose = require('mongoose');
const schema = mongoose.Schema;

let userSchema = new schema({
    _id: { type: schema.Types.ObjectId },
    firstName: { type: String },
    lastName: { type: String },
    username: { type: String, required: true },
    password: { type: String, required: true },
    email: { type: String },
    mobile: { type: String },
    verified: { type: String, default: 'N' },
    mobileVerified: { type: String, default: 'N' },
    emailVerified: { type: String, default: 'N' },
    balance: { type: Number, default: 0.00 },
    mfa: { type: String, default: 'N' },
    token: { type: String, default: null },
    currency: { type: String, enum: ['USD', 'INR', 'CAD'] },
    creationDate: { type: Date, default: Date.now() },
    lastUpdateDate: { type: Date, default: Date.now() },
});

module.exports = mongoose.model('user', userSchema);