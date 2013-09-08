
# Module dependencies.
expect = require 'expect.js'
request = require 'supertest'
sinon = require 'sinon'
user = require '../../lib/user'
User = require '../../lib/models/user'
specHelper = require '../spec-helper'

describe 'user', ->

  beforeEach ->
    @app = specHelper.setUpAppWithFakeSession.call @
    @app.use user

  describe 'GET /users', ->

    # getするrequestのwrapper
    get = -> request(@app).get('/new')

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

    describe '入力値が正しい場合', ->

      beforeEach ->
        @saveStub = sinon.stub User::, 'save', (cb) -> cb(null, _id: 'hoge')

      afterEach ->
        User::save.restore()

      # postするrequestのwrapper
      post = (excercise) ->
        request(@app)
          .post('/')
          .send(username: data.username, password: data.password, confirm: data.password)

      it '与えられたユーザ名でユーザを保存すること', (done) ->
        post.call(@)
          .end (err, res) =>
            expect(@saveStub.lastCall.thisValue).to.have.property 'username', data.username
            done()

      it '与えられたパスワードを暗号化してユーザを保存すること', (done) ->
        post.call(@)
          .end (err, res) =>
            expect(@saveStub.lastCall.thisValue).to.have.property 'password'
            expect(@saveStub.lastCall.thisValue.password).to.not.equal data.password
            done()

      it '`/rooms`にリダイレクトすること', (done) ->
        post.call(@)
          .end (err, res) =>
            done err if err
            expect(res.header.location).to.equal '/rooms'
            done()

      it 'sessionにユーザIDを保持していること', (done) ->
        post.call(@)
          .end (err, res) =>
            done err if err
            expect(@req.session.user_id).to.equal 'hoge'
            done()

    describe '入力値不正の場合', ->

      describe '確認用パスワード', ->

        beforeEach ->
          @saveStub = sinon.stub User::, 'save', (cb) -> cb(null, _id: 'hoge')

        afterEach ->
          User::save.restore()
  
        postWithInvalidPassword = (excercies) ->
          request(@app)
            .post('/')
            .send(username: data.username, password: data.password, confirm: 'piyo')

        it '保存しないこと', (done) ->
          postWithInvalidPassword.call(@)
            .end (err, res) =>
              done err if err
              expect(@saveStub.called).to.not.be.ok()
              done()

        it 'パスワードと一致しない場合新規作成画面を描画すること', (done) ->
          postWithInvalidPassword.call(@)
            .expect(/<input.+value=['"]Sign up['"].+>/, done)

        it 'パスワードが一致しない場合新規作成画面でエラー文言を描画すること', (done) ->
          postWithInvalidPassword.call(@)
            .expect(/class=['"]messages['"]/)
            .expect(/password dose not match/, done)

      describe '既存のユーザ名を指定した場合', ->

        beforeEach ->
          @saveStub = sinon.stub User::, 'save', (cb) ->
            cb(new Error('E11000 duplicate key error index'))

        afterEach ->
          User::save.restore()

        it 'エラー文言と共に新規作成画面を描画すること', (done) ->
          request(@app)
            .post('/')
            .send(username: data.username, password: data.password, confirm: data.password)
            .expect(/<input.+value=['"]Sign up['"].+>/)
            .expect(/class=['"]messages['"]/, done)
  
