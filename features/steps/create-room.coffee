
# Module dependencies.
assert = require 'assert'
expect = require 'expect.js'

createUserWrapper = module.exports = ->

  @World = require('../support/world').World

  @Given /^ログインする$/, (callback) ->
    
    # express the regexp above with the code you wish you had
    callback.pending()

  @Given /^招待対象のユーザが登録されている$/, (callback) ->
    
    # express the regexp above with the code you wish you had
    callback.pending()

  @Given /^会議室作成画面を開く$/, (callback) ->
    
    # express the regexp above with the code you wish you had
    callback.pending()

  @When /^タイトルを入力する$/, (callback) ->
    
    # express the regexp above with the code you wish you had
    callback.pending()

  @When /^詳細を入力する$/, (callback) ->
    
    # express the regexp above with the code you wish you had
    callback.pending()

  @When /^招待対象のユーザを参加ユーザとして指定する$/, (callback) ->
    
    # express the regexp above with the code you wish you had
    callback.pending()

  @When /^作成ボタンを押下する$/, (callback) ->
    
    # express the regexp above with the code you wish you had
    callback.pending()

  @Then /^会議室が作成されること$/, (callback) ->
    
    # express the regexp above with the code you wish you had
    callback.pending()

  @Then /^招待対象のユーザにメールが送信されること$/, (callback) ->
    
    # express the regexp above with the code you wish you had
    callback.pending()

  @Then /^作成された会議室に遷移されること$/, (callback) ->
    
    # express the regexp above with the code you wish you had
    callback.pending()