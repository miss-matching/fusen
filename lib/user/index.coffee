
# Module dependencies.
express = require 'express'
debug = require('debug') 'http'
User = require '../models/user'

app = module.exports = express()

# middlewre
app.use express.errorHandler()

# setting
app.set 'views', __dirname
app.set 'view engine', 'ejs'
app.locals.messages = []

# GET /
app.get '/', (req, res) ->
  res.render 'new'

# POST /
app.post '/', (req, res, next) ->
  unless req.body.password is req.body.confirm
    # パスワードが一致しない場合
    return res.render 'new', messages: ['password dose not match']

  user = new User(req.body)

  user.save (err, user) ->
    if err?.message.match /E11000/
      # ユーザ名が既に登録されている場合
      res.render 'new', messages: ['user already exists']
    else
      throw err if err
      req.session.user_id = user._id
      res.redirect '/rooms'
