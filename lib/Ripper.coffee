{ parse } = require 'esprima'
{ analyze } = require 'escope'
{ Context } = require 'esrefactor'
_ = require 'lodash'

{ inspect } = require 'util'

module.exports =
class Ripper

  # @rangeToLoc: ({ start, end }) ->
  #   start:
  #     line: start.row + 1
  #     column: start.column
  #   end:
  #     line: end.row + 1
  #     column: end.column
  #
  # @isEqualLoc: (a, b) ->
  #   a.start.line is b.start.line and
  #   a.start.column is b.start.column and
  #   a.end.line is b.end.line and
  #   a.end.column is b.end.column

  destruct: ->
    delete @scopes

  parse: (code, callback) ->
    ast = parse code, loc: true, range: true, tolerant: true, tokens: true
    @context = new Context
    @context.setCode ast

  find: (range) ->
    return [] unless @context?

    pos = 0
    row = range.start.row
    while --row > 0
      console.log row
      pos += @editor.lineLengthForBufferRow row
    pos += range.start.column
    console.log "-> #{pos}"

    { references } = @context.identify pos
    console.log references.length
    for reference in references
      console.log inspect reference



    # targetLocationData = rangeToLocationData range
    # foundNodes = Ripper.find @nodes, targetLocationData
    # for { locationData }, i in foundNodes
    #   locationDataToRange locationData
