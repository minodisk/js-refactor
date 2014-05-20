module.exports =
class Watcher extends require('atom-refactor').Watcher

  Ripper: require './Ripper'
  scopeNames: [
    'source.js'
  ]

  constructor: ->
    super
