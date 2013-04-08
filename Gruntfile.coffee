module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"

  # #########################################################################
  # CoffeeScript Compiling
  # #########################################################################
    coffee:
      compile:
        expand: true
        cwd: "src/coffee/"
        src: "**/*.coffee"
        dest: "dist/js/"
        ext: ".js"

  # #########################################################################
  # LESS Compiling
  # #########################################################################
    less:
      compile:
        files: [
          expand: true
          cwd: "src/less"
          src: [
            "**/*.less"       # include all LESS files
            "!**/_*.less"     # unless they start with an _
          ]
          dest: "dist/css"
          ext: ".css"
        ]

  # #########################################################################
  # Handlebars Compiling
  # #########################################################################
    handlebars:
      compile:
        options:
          namespace: "App.Templates"
          amd: true

          processName: (filename) ->
            filename = filename.replace /^src\/templates\//, ""
            filename = filename.replace /\.handlebars$/, ""

        files: [
          expand: true
          cwd: "src/templates"
          src: "**/*.handlebars"
          dest: "dist/js/templates/"
          ext: ".js"
        ]

  # #########################################################################
  # Require.JS
  # #########################################################################
    requirejs:
      compile:
        options:
          mainConfigFile: "dist/js/build.js"
          baseUrl: "dist/js"
          name: "main"
          include: ["build"]
          out: "dist/js/main.min.js"

  # #########################################################################
  # Connect Web Server
  # #########################################################################
    connect:
      server:
        options:
          port: 8000
          base: "dist"

  # #########################################################################
  # Watch
  # #########################################################################
    watch:
    # compile the source files
      compile:
        options:
          debounceDelay: 1000

        files: [
          "src/coffee/**/*.coffee"
          "src/templates/**/*.handlebars"
          "src/less/**/*.less"
        ]

        tasks: ["compile"]

    # copy the source files that do not need compiling
      other:
        options:
          debounceDelay: 1000

        files: [
          "src/js/**"
          "src/css"
          "src/*.*"
        ]

        tasks: ["copy:src"]


  # #########################################################################
  # Clean
  # #########################################################################
    clean:
      dist: ["dist"]

  # #########################################################################
  # Copy
  # #########################################################################
    copy:
    # TODO: Add Bower dependencies to copy from vendor/ to dist/**
      dist:
        files: [
          "dist/vendor/require.js": "vendor/requirejs/require.js"
          "dist/vendor/jquery.js": "vendor/jquery/jquery.js"
          "dist/vendor/underscore.js": "vendor/underscore-amd/underscore.js"
          "dist/vendor/backbone.js": "vendor/backbone-amd/backbone.js"
          "dist/vendor/handlebars.js": "vendor/handlebars/handlebars.js"
        ]

    # TODO: Add source files that do not need compiling
      src:
        files: [
          expand: true
          cwd: "src/"
          src: [
            "css/**"  # CSS Files
            "js/**"   # JS Files
            "*.*"     # Root-level Files, i.e: index.html
          ]
          dest: "dist/"
        ]

    # TODO: Add asset files here
      assets:
        files: [
          expand: true
          cwd: "assets"
          src: ["**"]
          dest: "dist/"
        ]

  # #########################################################################
  # Grunt Plugins
  # #########################################################################
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-handlebars"
  grunt.loadNpmTasks "grunt-contrib-less"
  grunt.loadNpmTasks "grunt-contrib-requirejs"
  grunt.loadNpmTasks "grunt-contrib-watch"


  # #########################################################################
  # Tasks
  # #########################################################################
  grunt.registerTask "default", ["develop"]

  grunt.registerTask "prepare", ["clean:dist", "copy:dist", "copy:src", "copy:assets"]
  grunt.registerTask "compile", ["coffee:compile", "handlebars:compile", "less:compile"]
  grunt.registerTask "develop", ["prepare", "compile", "connect:server", "watch"]
  grunt.registerTask "package", []
