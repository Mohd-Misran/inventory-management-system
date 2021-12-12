const mongoose = require('mongoose');
const CryptoJs = require('crypto-js');

const userSchema = mongoose.Schema({
  username: {
    type: String,
    required: [true, 'User must have a name.'],
    trim: true,
  },
  email: {
    type: String,
    required: [true, 'User must have an email.'],
    unique: true,
    trim: true,
  },
  password: {
    type: String,
    required: [true, 'User must have a password'],
    select: false,
  },
  salt: { type: String, select: false },
});

userSchema.pre('save', function (next) {
  this.salt = CryptoJs.lib.WordArray.random(128 / 8);
  const hash = CryptoJs.PBKDF2(this.password, this.salt, {
    keySize: 128 / 32,
  }).toString();
  this.password = hash;
  next();
});

userSchema.methods.validatePassword = function (candidatePwd, hash, salt) {
  const candidateHash = CryptoJs.PBKDF2(candidatePwd, salt, { keySize: 128 / 32 });
  return candidateHash == hash;
};

const User = mongoose.model('User', userSchema);

module.exports = User;
