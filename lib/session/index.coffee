
express = require 'express'
debug = require('debug') 'http'
User = require '../models/user'

app = module.exports = express()


# setting

app.set 'views', __dirname
app.set 'view engine', 'ejs'

# GET /sessions

app.get '/sessions', (req, res) ->
  res.render 'new'

# POST /sessions

app.post '/sessions', (req, res) ->
  User.findOne req.body, (err, user) ->
    throw err if err
    req.session.user_id = user._id
    res.redirect '/rooms'