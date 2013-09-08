
# Module dependencies.
mongoose = require 'mongoose'
ObjectId = mongoose.Schema.Types.ObjectId

# room schema
roomSchema = new mongoose.Schema
  title: String
  description: String
  created_user: ObjectId
  join_users: [ObjectId]
  created_at: Date
  updated_at: Date
  
roomSchema.pre 'save', (next) ->
  @updated_at = new Date
  @created_at = new Date unless @created_at?
  next()
# Expose Room model.
module.exports = mongoose.model('Room', roomSchema)
