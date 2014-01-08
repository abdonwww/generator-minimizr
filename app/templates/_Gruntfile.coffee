'use strict';

module.exports = (grunt) ->

  ###*
   Load grunt-* packages
  ###
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  ###*
   Initialize variables
  ###
  srcDir = 'src'
  distDir = 'dist'

  ###*
   Configure
  ###
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    ###*
     Imagemin
    ###
    imagemin:
      options:
        optimizationLevel: 3
        progressive: true
        interlaced: true
        pngquant: false
      production:
        files: [
          {
            expand: true
            flatten: true
            cwd: srcDir
            src: ['**/*.{png,jpg,gif}']
            dest: distDir
          }
        ]

    useminPrepare:
      compile:
        files: [
          {
            expand: true
            cwd: srcDir
            src: ['**/*.html']
          }
        ]
        options:
          dest: distDir
          root: srcDir
          # flow:
          #   steps:
          #     js: ['concat', 'uglify']
          #     css: ['concat', 'cssmin']
          #   post: {}

    usemin:
      html: ["#{distDir}/**/*.html"]

    copy:
      compile:
        files: [
          {
            expand: true
            flatten: false
            cwd: srcDir
            src: ['**/*.html']
            dest: distDir
          }
        ]

    clean:
      refresh:
        src: [distDir]

  ###*
   Register tasks
  ###
  grunt.registerTask "build", "Build all files", [
    "clean"
    "useminPrepare"
    "copy"
    "concat"
    "uglify"
    "cssmin"
    "usemin"
    "imagemin"
  ]

  grunt.registerTask "default", "Run default tasks", () ->
    grunt.task.run 'build'

