
expect = require 'expect.js'
express = require 'express'
request = require 'supertest'
sinon = require 'sinon'
session = require '../'
User = require '../../models/user'

describe 'session', ->

  beforeEach ->
    @app = express()
    @app.use express.bodyParser()
    @app.use (req, res, next) => # fake session
      @req = req
      @req.session = {}
      next()
    @app.use session

  describe 'GET /sessions', ->

    it 'ユーザ名の入力フィールドを表示すること', (done) ->
      request(@app)
        .get('/sessions')
        .expect(/<input.+name=['"]username['"].+>/)
        .end(done)

    it 'パスワードの入力フィールドを表示すること', (done) ->
      request(@app)
        .get('/sessions')
        .expect(/<input.+name=['"]password['"].+>/)
        .end(done)      

    it 'ログインボタンを表示すること', (done) ->
      request(@app)
        .get('/sessions')
        .expect(/<input.+value=['"]login['"].+>/)
        .end(done)      

  describe 'POST /sessions', ->

    beforeEach ->
      @findOneSpy = sinon.stub User, 'findOne', (params, callback) ->
        callback(null, _id: 'hoge')

    afterEach ->
      User.findOne.restore()

    describe 'ユーザコレクションへの問い合わせ', ->

      it 'ユーザ名で問い合わせすること', (done) -> 
        request(@app)
          .post('/sessions')
          .send(username:'aaaa', password: 'bbbb')
          .end (err, res) =>
            done(err) if err 
            expect(@findOneSpy.lastCall.args[0]).to.have.property 'username', 'aaaa'
            done()

      it 'パスワードで問い合わせすること', (done) -> 
        request(@app)
          .post('/sessions')
          .send(username:'aaaa', password: 'bbbb')
          .end (err, res) =>
            done(err) if err 
            expect(@findOneSpy.lastCall.args[0]).to.have.property 'password', 'bbbb'
            done()

    it 'sessionにユーザIDを保持していること', (done) ->
        request(@app)
          .post('/sessions')
          .send(username:'aaaa', password: 'bbbb')
          .end (err, res) =>
            done(err) if err
            expect(@req.session.user_id).to.equal 'hoge'
            done()

    it '`/rooms`リダイレクトすること', (done) ->
      request(@app)
        .post('/sessions')
        .send(username: 'aaaa', password: 'bbbb')
        .expect(302)
        .end (err, res) =>
          done(err) if err
          expect(res.header.location).to.equal '/rooms'
          done()




