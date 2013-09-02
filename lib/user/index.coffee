
# Module dependencies.

express = require 'express'
debug = require('debug') 'http'
User = require '../models/user'

app = module.exports = express()

# middlewre
app.use express.errorHandler()

# setting

app.set 'views', __dirname
app.set 'view engine', 'ejs'

# GET /users

app.get '/users', (req, res) ->
  res.render 'new'

# POST /users

app.post '/users', (req, res, next) ->
#  throw new Error('password confirm failed') unless req.body.password is req.body.confirm
  return res.render 'new' unless req.body.password is req.body.confirm
  user = new User(req.body)
  user.save (err, user) ->
    throw err if err
    req.session.user_id = user._id
    res.redirect '/rooms'
