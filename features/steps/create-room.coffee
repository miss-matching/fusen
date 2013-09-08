
# Module dependencies.
async = require 'async'
expect = require 'expect.js'
User = require '../../lib/models/user'
invitedUser = require('../fixtures/user')['invited user']

createUserWrapper = module.exports = ->

  @World = require('../support/world').World

  @Given /^ログインする$/, (callback) ->
    u = require('../fixtures/user')['registered user']
    async.series [
      (cb) => @visit 'http://localhost:3000/sessions', cb
      (cb) => 
        @browser
          .fill('username', u.username)
          .fill('password', u.password)
          .pressButton('login', cb)
      (cb) => 
        expect(@browser.location.href).to.match(/rooms/)
        cb()
    ], callback

  @Given /^招待対象のユーザが登録されている$/, (callback) ->
    User.create invitedUser, callback

  @Given /^会議室作成画面を開く$/, (callback) ->
    @visit 'http://localhost:3000/rooms/new', callback

  @When /^タイトルを入力する$/, (callback) ->
    @browser
      .fill('title', "会議")
    callback()

  @When /^詳細を入力する$/, (callback) ->
    @browser
      .fill('description', "詳細です")
    callback()

  @When /^招待対象のユーザを参加ユーザとして指定する$/, (callback) ->
    @browser
      .fill('invite', invitedUser.username)
    callback()

  @When /^作成ボタンを押下する$/, (callback) ->
    @browser
      .pressButton('Create', callback)

  @Then /^会議室が作成されること$/, (callback) ->
    
    # express the regexp above with the code you wish you had
    callback.pending()

  @Then /^招待対象のユーザにメールが送信されること$/, (callback) ->
    
    # express the regexp above with the code you wish you had
    callback.pending()

  @Then /^作成された会議室に遷移されること$/, (callback) ->
    
    # express the regexp above with the code you wish you had
    callback.pending()