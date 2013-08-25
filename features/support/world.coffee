# Module dependencies.

Zombie = require 'zombie'
async = require 'async'
debug = require('debug') 'cucumber'
mongoose = require 'mongoose'

# World

class World

  constructor: (callback) ->
    @browser = new Zombie()
    @app = require '../../app'
    @visit = (url, callback) => @browser.visit url, callback
    callback()

  # Boot server on localhost:3000.
 
  bootServer: (callback) ->
    @app.listen 3000
    callback()

  # Seed user.

  seedUser: (callback) ->
    data = require '../fixtures/user'
    users = mongoose.connection.db.collection 'users'
    users.insert data, callback
    
# Expose `World`.

exports.World = World
