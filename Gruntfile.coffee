{ spawn } = require 'child_process'

module.exports = (grunt) ->
  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    esteWatch:
      options:
        dirs: [
          'keymaps/**/*'
          'lib/**/*'
          'menus/**/*'
          'spec/**/*'
          'stylesheets/**/*'
          'node_modules/atom-refactor/**/*'
        ]
        livereload:
          enabled: false
      '*': ->
        [ 'apm:test' ]

  grunt.loadNpmTasks 'grunt-este-watch'

  grunt.registerTask 'apm:test', ->
    # done = @async()
    # apmTest = spawn 'apm', [ 'test' ]
    # apmTest.stdout.on 'data', (data) ->
    #   console.log data.toString 'utf-8'
    # apmTest.stderr.on 'data', (data) ->
    #   console.error data.toString 'utf-8'
    # apmTest.on 'close', ->
    #   grunt.log.writeln 'done: apm test'
    #   done()

    grunt.util.spawn
      cmd: 'apm'
      args: [ 'test' ]
    , (err, result, code) ->
      if err?
        grunt.util.error err
      if result?
        grunt.log.writeln result
      done()

  grunt.registerTask 'default', [
    'apm:test'
    'esteWatch'
  ]
