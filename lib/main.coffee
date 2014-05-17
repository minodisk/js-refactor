module.exports =
new class JSRefactor extends require('atom-refactor').Main

  Watcher: require './Watcher'
  renameCommand: 'js-refactor:rename'
  refactorCommand: 'js-refactor:refactor'

  constructor: ->
    super
