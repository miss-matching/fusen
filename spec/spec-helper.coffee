
# Module dependencies.
express = require 'express'
mongoose = require 'mongoose'
ObjectId = mongoose.Types.ObjectId

exports.setUpAppWithFakeSession = () ->
  @app = express()
  @app.use express.bodyParser()
  @app.use (req, res, next) => # fake session
    @req = req
    @req.session = {}
    next()

exports.setUpAppWithFakeLoggedinUser = () ->
  @app = express()
  @currentUserId = new ObjectId
  @app.use express.bodyParser()
  @app.use (req, res, next) => # fake session
    @req = req
    @req.session = user_id: @currentUserId
    next()
