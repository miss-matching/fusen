
# Module dependencies.

expect = require 'expect.js'
express = require 'express'
request = require 'supertest'
user = require '../'

describe 'user', ->

  beforeEach ->
    @app = express()
    @app.use user

  describe 'GET /users', ->

    it 'ユーザ名の入力フィールドを表示すること', (done) ->
      request(@app)
        .get('/users')
        .expect(/<input.+name=['"]username['"].+>/)
        .end(done)

    it 'パスワードの入力フィールドを表示すること', (done) ->
      request(@app)
        .get('/users')
        .expect(/<input.+name=['"]password['"].+>/)
        .end(done)

    it 'パスワード確認の入力フィールドを表示すること', (done) ->
      request(@app)
        .get('/users')
        .expect(/<input.+name=['"]confirm['"].+>/)
        .end(done)

    it 'Sign Upボタンを表示すること', (done) ->
      request(@app)
        .get('/users')
        .expect(/<input.+value=['"]Sign up['"].+>/)
        .end(done)

  describe 'POST /users', ->

    it '口をもってること', (done) ->
      request(@app)
        .post('/users')
        .expect(200, done)
  
