
# Module dependencies.
mongoose = require 'mongoose'
bcrypt = require 'bcrypt'

SALT_WORK_FACTOR = 10

# user schema
userSchema = new mongoose.Schema
  username: 
    type: String
    required: true
    unique: true
  password:
    type: String
    required: true

# Pre `save`.
# パスワードを暗号化する
# http://devsmash.com/blog/password-authentication-with-mongoose-and-bcrypt
#
# @param [Function] next
userSchema.pre 'save', (next) ->
  # only hash the password if it has been modified (or is new)
  => next() unless @isModified('password')

  # generate a salt
  bcrypt.genSalt SALT_WORK_FACTOR, (err, salt) =>
    => next(err) if err
    bcrypt.hash @password, salt, (err, hash) =>
      => next(err) if err

      # override the cleartext password with the hashed one
      @password = hash
      next()

# パスワードと`candidatePassword`を比較する
#
# @param [String] candidatePassword
# @param [Function] cb callback
userSchema.methods.comparePassword = (candidatePassword, cb) ->
  bcrypt.compare candidatePassword, @password, (err, isMatch) ->
    => cb(err) if err
    cb null, isMatch

# Expose User model.
module.exports = mongoose.model('User', userSchema)
