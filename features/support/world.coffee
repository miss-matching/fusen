# Module dependencies.
Zombie = require 'zombie'
async = require 'async'
debug = require('debug') 'cucumber'
mongoose = require 'mongoose'
User = require '../../lib/models/user'

# World
class World

  constructor: (callback) ->
    @browser = new Zombie()
    @app = require '../../app'
    @server = null
    @db = mongoose.connection.db
    @visit = (url, callback) => @browser.visit url, callback
    callback()

  # Boot server on localhost:3000.
  bootServer: (callback) ->
    @server = @app.listen 3000
    callback()

  # Shutdown server.
  shutdownServer: (callback) ->
    @server.close callback

  # Seed user.
  seedUser: (callback) ->
    data = require('../fixtures/user')['registered user']
    User.remove (err) ->
      throw err if err
      User.create data, callback
    
# Expose `World`.
exports.World = World
