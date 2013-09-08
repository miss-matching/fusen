
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

    it 'ステータスコード200を返すこと', (done) ->
      request(@app)
        .get('/new')
        .expect(200, done)

    it 'titleのインプットを描画する', (done) ->
      request(@app)
        .get('/new')
        .expect(/<input.+name=['"]title['"].+>/, done)

    it 'descriptionのテキストエリアを描画する', (done) ->
      request(@app)
        .get('/new')
        .expect(/<textarea.+name=['"]description['"].+>/, done)