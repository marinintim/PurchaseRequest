define "Views/Summary",
->
  SummaryView = Backbone.View.extend
    initialize: (options) ->
      @listenTo @model, "change", @render
    
    template: Handlebars.compile $("#pr-summary").html()
    
    render: ->
      _.defer => @$el.html @template @model.toJSON()