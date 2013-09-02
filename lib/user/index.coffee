
# Module dependencies.

express = require 'express'
debug = require('debug') 'http'
User = require '../models/user'

app = module.exports = express()

# setting

app.set 'views', __dirname
app.set 'view engine', 'ejs'

# GET /users

app.get '/users', (req, res) ->
  res.render 'new'

# POST /users

app.post '/users', (req, res) ->
  user = new User(req.body)
  user.save (err, user) ->
    throw err if err
    req.session.user_id = user._id
    res.redirect '/rooms'
