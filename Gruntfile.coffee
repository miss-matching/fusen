module.exports = (grunt) ->

  grunt.initConfig

    watch:
      coffee:
        files: ['app.coffee', 'lib/**/*.coffee', 'spec/**/*.coffee', 'lib/**/*.ejs']
        tasks: ['unit']

      cucumberjs:
        files: ['features/steps/**/*.coffee']
        tasks: ['feature']

    coffee:
      server:
        expand: on
        cwd: '.'
        src: ['app.coffee', 'lib/**/*.coffee']
        dest: '.'
        ext: '.js'        
      serverSpec:
        expand: on
        cwd: '.'
        src: ['spec/**/*.coffee']
        dest: '.'
        ext: '.spec.js'

    cucumberjs:
      files: 'features'

    mochaTest:
      unit:
        options:
          reporter: 'dot'
          growl: on
        src: ['spec/**/*.spec.js']

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

  grunt.registerTask 'ci', [
    'coffee'
    'mochaTest'
    'cucumberjs'
  ]
