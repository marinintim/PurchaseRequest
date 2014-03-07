define "Views/Error",
["Models/PurchaseRequest"],
(PurchaseRequest) ->
	Error = Backbone.View.extend {
		el: $('.pr-error')		

		template: Handlebars.compile $("#pr-error").html()
		render: (error) ->
			this.$el.html this.template error: error
		unrender: ->
			this.$el.html ""
	}