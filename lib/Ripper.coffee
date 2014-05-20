{ Context } = require '../thirdparty/esrefactor'
{ parse } = require 'esprima'
{ Range } = require 'atom'

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


  @locToRange: ({ start, end }) ->
    new Range [ start.line - 1, start.column ], [ end.line - 1, end.column ]



  parseOptions:
    loc: true
    range: true
    tokens: true
    tolerant: true

  constructor: (@editor) ->
    @context = new Context

  destruct: ->
    delete @context

  parse: (code, callback) ->
    try
      syntax = parse code, @parseOptions
      @context.setCode syntax
      callback null
    catch err
      callback err

  find: (range) ->
    pos = 0
    row = range.start.row
    while --row >= 0
      pos += 1 + @editor.lineLengthForBufferRow row
    pos += range.start.column

    identification = @context.identify pos
    return [] unless identification

    { declaration, references } = identification
    references.unshift declaration
    ranges = []
    for reference in references
      ranges.push Ripper.locToRange reference.loc
    ranges
