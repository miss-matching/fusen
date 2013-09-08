
# Module dependencies.
expect = require 'expect.js'
request = require 'supertest'
sinon = require 'sinon'
session = require '../../lib/session'
User = require '../../lib/models/user'
specHelper = require '../spec-helper'

describe 'session', ->

  beforeEach ->
    @app = specHelper.setUpAppWithFakeSession.call @
    @app.use session

  describe 'GET /sessions', ->

    # getするrequestのwrapper
    get = -> request(@app).get('/new')

    it 'ユーザ名の入力フィールドを表示すること', (done) ->
      get.call(@)
        .expect(/<input.+name=['"]username['"].+>/, done)

    it 'パスワードの入力フィールドを表示すること', (done) ->
      get.call(@)
        .expect(/<input.+name=['"]password['"].+>/, done)

    it 'ログインボタンを表示すること', (done) ->
      get.call(@)
        .expect(/<input.+value=['"]login['"].+>/, done)

  describe 'POST /sessions', ->

    # postするrequestのwrapper
    post = (excercise) ->
      request(@app)
        .post('/')
        .send(username: 'aaaa', password: 'bbbb')  

    beforeEach ->
      @comparePasswordStub = sinon.stub()
      @findOneSpy = sinon.stub User, 'findOne', (params, callback) =>
        callback(null, _id: 'hoge', comparePassword: @comparePasswordStub)
      @comparePasswordStub.callsArgWith 1, null, true

    afterEach ->
      User.findOne.restore()

    describe 'ユーザコレクションへの問い合わせ', ->

      it 'ユーザ名で問い合わせすること', (done) ->
        post.call(@)
          .end (err, res) =>
            done(err) if err 
            expect(@findOneSpy.lastCall.args[0]).to.have.property 'username', 'aaaa'
            done()

      it 'User#comparePasswordで入力されたパスワードを比較すること', (done) ->
        post.call(@)
          .end (err, res) =>
            done(err) if err 
            expect(@comparePasswordStub.called).to.be.ok()
            done()

      describe 'User#comparePasswordの結果がマッチしないとき', ->

        beforeEach ->
          @comparePasswordStub.resetBehavior()
          @comparePasswordStub.callsArgWith 1, null, false

        it 'ログイン画面を表示すること', (done) ->
          post.call(@)
            .expect(/<input.+value=['"]login['"].+>/, done)

        it 'username又はpasswordが間違っている旨表示すること', (done) ->
          post.call(@)
            .expect(/class=['"]messages['"]/)
            .expect(/Name or password is incorrect/, done)

    it 'sessionにユーザIDを保持していること', (done) ->
      post.call(@)
        .end (err, res) =>
          done(err) if err
          expect(@req.session.user_id).to.equal 'hoge'
          done()

    it '`/rooms`リダイレクトすること', (done) ->
      post.call(@)
        .expect(302)
        .end (err, res) =>
          done(err) if err
          expect(res.header.location).to.equal '/rooms'
          done()
