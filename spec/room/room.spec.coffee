
# Module dependencies.
expect = require 'expect.js'
request = require 'supertest'
sinon = require 'sinon'
room = require '../../lib/room'
Room = require '../../lib/models/room'
User = require '../../lib/models/user'
specHelper = require '../spec-helper'
mongoose = require 'mongoose'
ObjectId = mongoose.Types.ObjectId

describe 'room', ->

  beforeEach ->
    @app = specHelper.setUpAppWithFakeLoggedinUser.call @
    @app.use room

  describe 'GET /new', ->

    # getするreqestのrapper
    get = -> request(@app).get('/new')

    it 'ステータスコード200を返すこと', (done) ->
      get.call(@)
        .expect(200, done)

    it 'titleのインプットを描画する', (done) ->
      get.call(@)
        .expect(/<input.+name=['"]title['"].+>/, done)

    it 'descriptionのテキストエリアを描画する', (done) ->
      get.call(@)
        .expect(/<textarea.+name=['"]description['"].+>/, done)

    it 'inviteのインプットを描画する', (done) ->
      get.call(@)
        .expect(/<input.+name=['"]invite['"].+>/, done)

    it 'Createボタンを描画する', (done) ->
      get.call(@)
        .expect(/<input.+value=['"]Create['"].+>/, done)

  describe 'POST /', ->
    it 'ステータスコード200を返すこと', (done) ->
      request(@app)
        .post('/')
        .expect(200, done)

    data =
      title: 'saved room title'

    beforeEach ->
      @invitedUserId = new ObjectId
      @saveStub = sinon.stub Room::, 'save', (cb) -> cb(null, _id: 'hoge')
      @userFindOneStub = sinon.stub User, 'findOne', (cond, cb) => cb(null, _id: @invitedUserId)

    afterEach ->
      Room::save.restore()
      User.findOne.restore()

    it 'タイトルを保存すること', (done) ->
      request(@app)
        .post('/')
        .send(title: data.title)
        .end (err, res) =>
          expect(@saveStub.lastCall.thisValue).to.have.property 'title', data.title
          done()

    it '作成者としてログインしているユーザを保存すること', (done) ->
      request(@app)
        .post('/')
        .send(title: data.title)
        .end (err, res) =>
          expect(@saveStub.lastCall.thisValue).to.have.property 'created_user', @currentUserId
          done()

    it '招待するユーザを保存すること', (done) ->
      request(@app)
        .post('/')
        .send(title: data.title, invite: 'hoge')
        .end (err, res) =>
          expect(@saveStub.lastCall.thisValue).to.have.property 'join_users'
          expect(@saveStub.lastCall.thisValue.join_users).to.contain @invitedUserId
          done()
