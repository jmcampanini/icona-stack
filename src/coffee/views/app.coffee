define ["jquery", "backbone", "templates/test"], ($, Backbone, AppTemplates) ->
  class AppView extends Backbone.View

    initialize: ->
      console.log "hallo world!"

      context = "hello": "world"
      html = AppTemplates["test"] context
      $("body").append html
