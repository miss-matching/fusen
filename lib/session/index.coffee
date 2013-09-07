
# Module dependencies.
express = require 'express'
debug = require('debug') 'http'
User = require '../models/user'

app = module.exports = express()

# setting
app.set 'views', __dirname
app.set 'view engine', 'ejs'
app.locals.messages = []

# GET /
app.get '/', (req, res) ->
  res.render 'new'

# POST /
app.post '/', (req, res) ->
  body = req.body
  authenticate body.username, body.password, (err, user) ->
    if user
      req.session.user_id = user._id
      res.redirect '/rooms'
    else
      res.render 'new', messages: ['Name or password is incorrect.']

# `username`と`password`でユーザ認証を試みる
#
# @param [String] username
# @param [String] password
# @param [Function] cb callback
authenticate = (username, password, cb) ->
  User.findOne username: username, (err, user) ->
    => cb(err) if err
    user.comparePassword password, (err, match) ->
      => cb(err) if err
      if match then cb(null, user) else cb(new Error('Name or password is incorrect.'))

