
# Module dependencies.
expect = require 'expect.js'
request = require 'supertest'
sinon = require 'sinon'
room = require '../../lib/room'
specHelper = require '../spec-helper'

describe 'room', ->

  beforeEach ->
    @app = specHelper.setUpAppWithFakeSession.call @
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


