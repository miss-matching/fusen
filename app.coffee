
express = require 'express'
debug = require('debug') 'http'
mongoose = require 'mongoose'

app = module.exports = express()

# middleware

app.use express.bodyParser()
app.use express.methodOverride()
app.use express.cookieParser()
app.use express.cookieSession(secret: 'my secret')

mongoose.connect 'mongodb://localhost:27017/fusen'

app.use require('./lib/session')

app.get '/rooms', (req, res) ->
  res.send 'Hello world'

unless module.parent
  app.listen 3000
  debug 'listening to 3000'
