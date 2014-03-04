define "Views/CreditCard",
["Models/CreditCard"],
(CreditCard) ->
	CreditCardView = Backbone.View.extend {
		el: $(".pr-creditcard")
		events:
			"change .pr-creditcard-select": "renderForm"
		initialize: ->
			this.model = new CreditCard

		template: Handlebars.compile $("#pr-creditcard").html()
		templateForm: Handlebars.compile $("#pr-creditcard-form").html()
		render: ->
			console.log "rendering creditcard"
			this.$el.html this.template({ selected: this.model.id })
		renderForm: ->
			this.render()
			console.log('and form')
			this.$el.append(this.templateForm())
	}