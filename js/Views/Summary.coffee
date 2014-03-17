define "Views/Summary",
["Models/PurchaseRequest"],
(PurchaseRequest) ->
	SummaryView = Backbone.View.extend {
		el: $('.pr-summary')
		events:
			"change model": "render"
		initialize: ->
			@listenTo @model, "change", @render
			

		template: Handlebars.compile $("#pr-summary").html()
		render: ->
			@$el.html @template @model.toJSON()
	}