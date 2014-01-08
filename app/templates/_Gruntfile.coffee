'use strict';

module.exports = (grunt) ->

  ###*
   Load grunt-* packages
  ###
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

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
            cwd: "src"
            src: ['**/*.{png,jpg,gif}']
            dest: "dist"
          }
        ]

    useminPrepare:
      compile:
        files: [
          {
            expand: true
            cwd: "src/"
            src: ['**/*.html']
          }
        ]
        options:
          dest: 'dist'
          root: 'src'
          # flow:
          #   steps:
          #     js: ['concat', 'uglify']
          #     css: ['concat', 'cssmin']
          #   post: {}

    usemin:
      html: ['dist/**/*.html']

    copy:
      compile:
        files: [
          {
            expand: true
            flatten: false
            cwd: "src"
            src: ['**/*.html']
            dest: "dist"
          }
        ]

    clean:
      refresh:
        src: ["dist"]

  ###*
   Register tasks
  ###
  grunt.registerTask "build:development", "Build for development", [
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
    grunt.task.run 'build:development'

