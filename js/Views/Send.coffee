define "Views/Send",
->
  SendView = Backbone.View.extend
    events:
      "click": "send"
    initialize: (options) ->
      @listenTo @model, "error", @handleError

    send: ->
      @model.save
        success: (model, xhr) ->
          window.location.replace xhr.redirect_url.toString()
    
    handleError: (model, xhr) ->
      if xhr.status == 500 then @$el.attr('disabled','disabled')
