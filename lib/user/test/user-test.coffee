
# Module dependencies.

expect = require 'expect.js'
express = require 'express'
request = require 'supertest'
sinon = require 'sinon'
user = require '../'
User = require '../../models/user'

describe 'user', ->

  beforeEach ->
    @app = express()
    @app.use express.bodyParser()
    @app.use user

  describe 'GET /users', ->

    # getするrequestのwrapper

    get = -> request(@app).get('/users')
  
    it 'ユーザ名の入力フィールドを表示すること', (done) ->
      get.call(@)
        .expect(/<input.+name=['"]username['"].+>/, done)

    it 'パスワードの入力フィールドを表示すること', (done) ->
      get.call(@)
        .expect(/<input.+name=['"]password['"].+>/, done)

    it 'パスワード確認の入力フィールドを表示すること', (done) ->
      get.call(@)
        .expect(/<input.+name=['"]confirm['"].+>/, done)

    it 'Sign Upボタンを表示すること', (done) ->
      get.call(@)
        .expect(/<input.+value=['"]Sign up['"].+>/, done)

  describe 'POST /users', ->

    data =
      username: 'saved user name'
      password: 'saved user password'

    beforeEach ->
      @saveSpy = sinon.spy User::, 'save'

    afterEach ->
      User::save.restore()

    # postするrequestのwrapper
 
    post = (excercise) ->
      request(@app)
        .post('/users')
        .send(username: data.username, password: data.password, confirm: data.password)

    it '与えられたユーザ名でユーザを保存すること', (done) ->
      post.call(@)
        .end (err, res) =>
          expect(@saveSpy.lastCall.thisValue).to.have.property 'username', data.username
          done()

    it '与えられたパスワードでユーザを保存すること', (done) ->
      post.call(@)
        .end (err, res) =>
          expect(@saveSpy.lastCall.thisValue).to.have.property 'password', data.password
          done()

    describe '確認用パスワード', ->

      it 'パスワードと一致しない場合エラーを返却すること'

