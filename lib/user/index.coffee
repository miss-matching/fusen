
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
  res.send 'Hello'
