
# Module dependencies.

expect = require 'expect.js'
mongoose = require 'mongoose'
Room = require '../../lib/models/room'
app = require '../../app'
ObjectId = mongoose.Types.ObjectId

describe 'Room', ->

  beforeEach (done) ->
    Room.remove done

  it 'mongoose.Modelのインスタンスであること', ->
    expect(new Room).to.be.a(mongoose.Model)

  describe 'フィールド', ->

    beforeEach ->
      @createdUser = new ObjectId
      @joinUser = new ObjectId
      @room = new Room 
        title: 'aaaa'
        description: 'bbbb'
        created_user: @createdUser
        join_users: [@joinUser]

    it 'titleフィールドを持っていること', ->
      expect(@room).to.have.property 'title', 'aaaa'

    it 'descriptionフィールドを持っていること', ->
      expect(@room).to.have.property 'description', 'bbbb'

    it 'created_userフィールドを持っていること', ->
      expect(@room).to.have.property 'created_user', @createdUser

    it 'join_usersフィールドを持っていること', ->
      expect(@room).to.have.property 'join_users'
      expect(@room.join_users.map((u) -> u.toString())).to.contain @joinUser.toString()

    it 'created_atフィールドを持っていること', ->
      @room.save (err, room) ->
        expect(room).to.have.property 'created_at'
        expect(room.created_at).to.be.a Date

    it 'updated_atフィールドを持っていること', ->
      @room.save (err, room) ->
        expect(room).to.have.property 'updated_at'
        expect(room.updated_at).to.be.a Date
