
# Module dependencies.
assert = require 'assert'
expect = require 'expect.js'

createUserWrapper = module.exports = ->

  user = (exists = false) ->
    key = if exists then 'registered user' else 'not registered user'
    require('../fixtures/user')[key]

  @World = require('../support/world').World

  @Given /^ユーザ作成画面を開く$/, (callback) ->
    @visit 'http://localhost:3000/users/new', callback

  @When /^ユーザ名、パスワード、パスワードの確認を入力してサブミットする$/, (callback) ->
    u = user()
    @browser
      .fill('username', u.username)
      .fill('password', u.password)
      .fill('confirm', u.password)
      .pressButton('Sign up', callback)

  @When /^ユーザ名を入力し、パスワードとパスワードの確認に異なる値を入力してサブミットする$/, (callback) ->
    u = user()
    @browser
      .fill('username', u.username)
      .fill('password', u.password + '!')
      .fill('confirm', u.password)
      .pressButton('Sign up', callback)

  @When /^既存のユーザ名、パスワード、パスワードの確認を入力してサブミットする$/, (callback) ->
    u = user true
    @browser
      .fill('username', u.username)
      .fill('password', u.password)
      .fill('confirm', u.password)
      .pressButton('Sign up', callback)
  
  @Then /^ユーザ登録されていること$/, (callback) ->
    u = user()
    @db.collection('users')
      .findOne username: u.username, (err, user) =>
        callback.fail(err) if err
        callback.fail('username not match') unless user.username is u.username
        callback()

  @Then /^会議室にリダイレクトされること$/, (callback) ->
    if @browser.location.href.match(/rooms/)
      callback()
    else
      callback.fail 'not redirected'

  @Then /^ユーザ登録されていないこと$/, (callback) ->
    u = user()
    @db.collection('users')
      .findOne username: u.username, (err, user) =>
        callback.fail(err) if err
        if user then callback.fail('user should not be saved') else callback()

  @Then /^ユーザ作成画面が表示されること$/, (callback) ->
    expect(@browser.query 'input[value="Sign up"]').to.not.be null
    callback()

  @Then /^パスワードとパスワードの確認の値が異なる旨の警告メッセージが表示されること$/, (callback) ->
    expect(@browser.query '.messages').to.not.be null
    expect(@browser.text '.messages').to.contain 'password dose not match'
    callback()

  @Then /^既に入力されたユーザ名使用されている旨の警告メッセージが表示されること$/, (callback) ->
    expect(@browser.query '.messages').to.not.be null
    expect(@browser.text '.messages').to.contain 'user already exists'
    callback()
  
