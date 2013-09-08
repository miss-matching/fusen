
# Module dependencies.
express = require 'express'
debug = require('debug') 'http'
User = require '../models/user'

app = module.exports = express()

# setting
app.set 'views', __dirname
app.set 'view engine', 'ejs'
app.locals.messages = []

# GET /new
app.get '/new', (req, res) ->
  res.render 'new'

# GET /
app.get '/', (req, res) ->
  res.send 'Hello world'