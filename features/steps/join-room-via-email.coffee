
# Module dependencies.
assert = require 'assert'
expect = require 'expect.js'

createUserWrapper = module.exports = ->

  @World = require('../support/world').World
  
  @Given /^招待された会議室が作成されている$/, (callback) ->
    
    # express the regexp above with the code you wish you had
    callback.pending()

  @Given /^招待メールを受信している$/, (callback) ->
    
    # express the regexp above with the code you wish you had
    callback.pending()

  @When /^招待メールのリンクを押下する$/, (callback) ->
    
    # express the regexp above with the code you wish you had
    callback.pending()

  @Then /^招待された会議室に遷移されること$/, (callback) ->
    
    # express the regexp above with the code you wish you had
    callback.pending()