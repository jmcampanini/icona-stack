require.config
  deps: ["main"]
  paths:
    "jquery": "../plugins/jquery/jquery"
    "underscore": "../plugins/lodash/lodash"
    "backbone": "../plugins/backbone-amd/backbone"
    "handlebars": "../plugins/handlebars/handlebars"

  shim:
    "handlebars":
      exports: "Handlebars"
