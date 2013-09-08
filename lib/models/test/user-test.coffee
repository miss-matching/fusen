
# Module dependencies.

expect = require 'expect.js'
mongoose = require 'mongoose'
User = require '../user'
app = require '../../../app'

describe 'User', ->

  beforeEach (done) ->
    User.remove done

  it 'mongoose.Modelのインスタンスであること', ->
    expect(new User).to.be.a(mongoose.Model)

  describe 'フィールド', ->

    beforeEach ->
      @user = new User(username: 'aaaa', password: 'bbbb')

    it 'usernameフィールドを持っていること', ->
      expect(@user).to.have.property 'username', 'aaaa'

    it 'passwordフィールドを持っていること', ->
      expect(@user).to.have.property 'password', 'bbbb'

  describe 'username', ->

    it '重複するusernameで保存した場合エラーを返却すること', (done) ->
      User.create username: 'abc', password: 'def', (err) ->
        done err if err
        User.create username: 'abc', password: 'def', (err) ->
          expect(err.message).to.match /E11000 duplicate key error index/
          done()
