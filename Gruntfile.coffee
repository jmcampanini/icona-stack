module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"

  # #########################################################################
  # CoffeeScript Compiling
  # #########################################################################
    coffee:
      compile:
        options:
          bare: true

        expand: true
        cwd: "src/coffee"
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
          dest: "dist/css/"
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
            # remove the `src/templates` prefix and .handlebars extension
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
  # TODO: `package` Task
  #  requirejs:
  #    compile:
  #      options:
  #        mainConfigFile: "dist/js/build.js"
  #        baseUrl: "dist/js"
  #        name: "main"
  #        include: ["build"]
  #        out: "dist/src/js/main.min.js"

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
      coffee:
        options:
          debounceDelay: 1000

        files: ["src/coffee/**"]
        tasks: ["coffee:compile"]

      less:
        options:
          debounceDelay: 1000

        files: ["src/less/**"]
        tasks: ["less:compile"]


      handlebars:
        options:
          debounceDelay: 1000

        files: ["src/templates/**"]
        tasks: ["handlebars:compile"]

      other:
        options:
          debounceDelay: 1000

        files: [
          "src/js/**"
          "src/css/**"
          "src/assets/**"
          "src/*.*"
        ]

        tasks: ["copy:src"]

  # #########################################################################
  # Clean
  # #########################################################################
    clean:
      dist: ["dist"]
      plugins: ["plugins"]

  # #########################################################################
  # Copy
  # #########################################################################
    copy:
      src:
        files: [
          expand: true
          cwd: "src/"
          src: [          # TODO: Add source files that do not need compiling
            "js/**"       # JS Files
            "css/**"      # CSS Files
            "assets/**"   # Assets
            "*.*"         # Root-level Files, i.e: index.html
          ]
          dest: "dist/"
        ]

      plugins:
        files: [
          expand: true
          cwd: "plugins"
          src: "**"
          dest: "dist/plugins/"
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

  grunt.registerTask "compile-all", ["coffee:compile"
                                     "handlebars:compile"
                                     "less:compile"]

  grunt.registerTask "prepare", ["clean:dist"
                                 "copy:src"
                                 "copy:plugins"
                                 "compile-all"]

  grunt.registerTask "develop", ["connect:server"
                                 "watch"]

  grunt.registerTask "package", []
