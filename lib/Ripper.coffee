esprima = require 'esprima'
{ utils: { LocationDataUtil: { locationDataToRange, rangeToLocationData, isEqualsLocationData }}} = require 'atom-refactor'


module.exports =
class Ripper

  destruct: ->
    delete @nodes

  parse: (code, callback) ->
    # try
    #   rawNodes = nodes code
    # catch err
    #   callback? err
    #   return
    # @nodes = Ripper.generateNodes rawNodes
    # callback?()

  find: (range) ->
    return [] unless @nodes?
    targetLocationData = rangeToLocationData range
    foundNodes = Ripper.find @nodes, targetLocationData
    for { locationData }, i in foundNodes
      locationDataToRange locationData
