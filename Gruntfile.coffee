module.exports = (grunt) ->

  grunt.initConfig

    watch:
      coffee:
        files: ['app.coffee', 'lib/**/*.coffee']
        tasks: ['unit']

    coffee:
      server:
        expand: on
        cwd: '.'
        src: ['app.coffee', 'lib/**/*.coffee']
        dest: '.'
        ext: '.js'        

    cucumberjs:
      files: 'features'

    mochaTest:
      unit:
        options:
          reporter: 'dot'
          growl: on
        src: ['lib/**/test/*-test.js']

  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-cucumber'
  grunt.loadNpmTasks 'grunt-mocha-test'

  grunt.registerTask 'feature', [
    'coffee'
    'cucumberjs'
  ]

  grunt.registerTask 'unit', [
    'coffee'
    'mochaTest'
  ]
