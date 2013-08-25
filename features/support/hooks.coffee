
# Module dependencies.

async = require 'async'

module.exports = ->

  @Before (callback) ->
    async.series [
      (cb) => @bootServer cb
      (cb) => @seedUser cb
    ], callback