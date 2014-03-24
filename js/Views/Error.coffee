define "Views/Error",
->
  Error = Backbone.View.extend
    template: Handlebars.compile $("#pr-error").html()

    initialize: (options) ->
      @listenTo @model, "invalid", @renderValidation
      @listenTo @model, "error", @renderServer
      @listenTo @model, "request", @unrender

    renderValidation: (model, validationError) ->
      _.defer => @$el.html @template
        error: validationError

    renderServer: (model,xhr) ->
      _.defer => @$el.html @template
        error: xhr.responseJSON.error
        
    unrender: ->
      _.defer => @$el.html ""