define "Views/Error",
["Models/PurchaseRequest"],
(PurchaseRequest) ->
	Error = Backbone.View.extend {
		el: $('.pr-error')		

		template: Handlebars.compile $("#pr-error").html()
		render: (error) ->
			@$el.html @template error: error
		unrender: ->
			@$el.html ""
	}