
# Module dependencies.
express = require 'express'
  
exports.setUpAppWithFakeSession = () ->
  @app = express()
  @app.use express.bodyParser()
  @app.use (req, res, next) => # fake session
    @req = req
    @req.session = {}
    next()
  
