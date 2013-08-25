
# Module dependencies.

mongoose = require 'mongoose'

# user schema

userSchema = new mongoose.Schema(
  username: 
    type: String
    required: true
  password:
    type: String
    required: true
)

# Expose User model.

module.exports = mongoose.model('User', userSchema)
