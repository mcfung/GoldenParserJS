module.exports = (grunt) ->

  grunt.initConfig
    'nodeunit':
      all: 'test/**/*_test.js'

  grunt.loadNpmTasks 'grunt-contrib-nodeunit'
  grunt.registerTask 'default', ['nodeunit']