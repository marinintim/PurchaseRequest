define "Views/Summary",
["Models/PurchaseRequest"],
(PurchaseRequest) ->
	SummaryView = Backbone.View.extend {
		el: $('.pr-summary')
		events:
			"change model": "render"
		initialize: ->
			###
			for k of this.model.attributes				
				this.listenTo k, "change", this.render
				
			###
			this.listenTo this.model, "change", this.render
			this.render()
			###
			setTimeout func = (=>
				this.render()
				setTimeout func, 5
			), 5
			###

		template: Handlebars.compile $("#pr-summary").html()
		render: ->
			console.log "rendering summary #{window.performance.now()}"
			this.$el.html this.template this.model.toJSON()
	}