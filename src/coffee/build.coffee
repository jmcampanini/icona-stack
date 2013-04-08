require.config
  deps: ["main"]
  paths:
    "jquery": "../vendor/jquery"
    "underscore": "../vendor/underscore"
    "backbone": "../vendor/backbone"
    "handlebars": "../vendor/handlebars"

  shim:
    "handlebars":
      exports: "Handlebars"
