
createUserWrapper = module.exports = ->

  @World = require('../support/world').World

  @Given /^ユーザ作成画面を開く$/, (callback) ->
    @visit 'http://localhost:3000/users', callback

  @When /^ユーザ名、パスワード、パスワードの確認を入力してサブミットする$/, (callback) ->
    u = require('../fixtures/user')[1]
    @browser
      .fill('username', u.username)
      .fill('password', u.password)
      .fill('confirm', u.password)
      .pressButton('Sign up', callback)

  @Then /^ユーザ登録されていること$/, (callback) ->
    callback.pending()

  @Then /^「会議室」にリダイレクトされること$/, (callback) ->
    callback.pending()

