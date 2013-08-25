
createUserWrapper = module.exports = ->

  @World = require('../support/world').World

  @Given /^ユーザ作成画面を開く$/, (callback) ->
    callback.pending()

  @When /^ユーザ名を入力する$/, (callback) ->
    callback.pending()

  @When /^パスワードを入力する$/, (callback) ->
    callback.pending()

  @When /^パスワードの確認を入力する$/, (callback) ->
    callback.pending()

  @When /^サブミットする$/, (callback) ->
    callback.pending()

  @Then /^ユーザ登録されていること$/, (callback) ->
    callback.pending()
