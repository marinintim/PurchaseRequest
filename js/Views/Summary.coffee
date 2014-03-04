define "Views/Summary",
["Models/PurchaseRequest"],
(PurchaseRequest) ->
	SummaryView = Backbone.View.extend {
		el: $('.pr-summary')

		initialize: ->
			this.listenTo this.model, "change", this.render
			this.render()

		template: Handlebars.compile $("#pr-summary").html()
		render: ->
			console.log "rendering summary"
			this.$el.html this.template this.model.toJSON()
	}