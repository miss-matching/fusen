
# Module dependencies.

expect = require 'expect.js'
mongoose = require 'mongoose'
User = require '../user'
app = require '../../../app'

describe 'User', ->

  it 'mongoose.Modelのインスタンスであること', ->
    expect(new User).to.be.a(mongoose.Model)

  describe 'フィールド', ->

    beforeEach ->
      @user = new User(username: 'aaaa', password: 'bbbb')

    it 'usernameフィールドを持っていること', ->
      expect(@user).to.have.property 'username', 'aaaa'

    it 'passwordフィールドを持っていること', ->
      expect(@user).to.have.property 'password', 'bbbb'
