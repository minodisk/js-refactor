# { parse } = require 'esprima'
esprima = require 'esprima'
# { analyze } = require 'escope'
esrefactor = require 'esrefactor'
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
    delete @context

  parse: (code, callback) ->
    # @context = new Context
    # try
    #   @context.setCode """
    #   var cache, fibonacci, index, _i;
    #
    #   cache = [0, 1];
    #
    #   fibonacci = function(n) {
    #     if (cache[n] != null) return cache[n];
    #     return cache[n] = fibonacci(n - 1) + fibonacci(n - 2);
    #   };
    #
    #   for (index = _i = 0; _i <= 10; index = ++_i) {
    #     console.log(index, fibonacci(index));
    #   }
    #   """
    # catch err
    #   delete @context
    #   console.error err

  find: (range) ->
    # return [] unless @context?

    code = """var cache, fibonacci, index, _i;

    cache = [0, 1];

    fibonacci = function(n) {
      if (cache[n] != null) return cache[n];
      return cache[n] = fibonacci(n - 1) + fibonacci(n - 2);
    };

    for (index = _i = 0; _i <= 10; index = ++_i) {
      console.log(index, fibonacci(index));
    }""".replace(/\n/g, '')
    console.log code
    try
      options =
        loc: true
        range: true
        tolerant: true
        tokens: true
      context = new esrefactor.Context
      syntax = esprima.parse code, options
      context.setCode syntax
    catch err
      console.error 'error'
      console.error err

    for i in [0...100]
      result = context.identify i
      # if result.references?
      console.log i, result.references

    # pos = 0
    # row = range.start.row
    # while --row > 0
    #   console.log row
    #   pos += @editor.lineLengthForBufferRow row
    # pos += range.start.column
    # console.log "-> #{pos}"
    #
    # { references } = @context.identify pos
    # console.log references.length
    # for reference in references
    #   console.log inspect reference



    # targetLocationData = rangeToLocationData range
    # foundNodes = Ripper.find @nodes, targetLocationData
    # for { locationData }, i in foundNodes
    #   locationDataToRange locationData
