
loginWrapper = module.exports = ->

  @World = require('../support/world').World

  @Given /^ログイン画面を開く$/, (callback) ->
    @visit 'http://localhost:3000/sessions', callback

  @When /^ユーザ名とパスワードを入力してサブミットする$/, (callback) ->  
    u = require('../fixtures/user')['registered user']
    @browser
      .fill('username', u.username)
      .fill('password', u.password)
      .pressButton('login', callback)

  @Then /^「会議室」にリダイレクトされること$/, (callback) ->
    callback.fail(new Error('hoge')) unless @browser.location.href.match(/rooms/)
    callback()

