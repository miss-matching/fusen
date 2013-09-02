
# Module dependencies.

assert = require 'assert'

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

  @Then /^ユーザ登録されていること、「会議室」にリダイレクトされること$/, (callback) ->
    u = require('../fixtures/user')[1]
    @db.collection('users')
      .findOne username: u.username, password: u.password, (err, user) =>
        callback.fail(err) if err
        callback.fail('username not match') unless user.username is u.username
        callback.fail('password not match') unless user.password is u.password
        callback.fail('not redirected') unless @browser.location.href.match(/rooms/)
        callback()
