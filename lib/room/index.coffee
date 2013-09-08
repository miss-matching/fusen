
# Module dependencies.
express = require 'express'
debug = require('debug') 'http'
Room = require '../models/room'
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

# POST /
app.post '/', (req, res) ->
  room = new Room req.body
  room.created_user = req.session.user_id 
  User.findOne username: req.body.invite, (err, user) ->
    throw err if err
    room.join_users.push user._id
    room.save (err, room) ->
      throw err if err
      res.send 'Hello world'

