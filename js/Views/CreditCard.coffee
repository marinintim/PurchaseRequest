define "Views/CreditCard",
["Models/CreditCard","Collections/CreditCard"],
(CreditCard, CreditCardCollection) ->
	CreditCardView = Backbone.View.extend 
		el: $(".pr-creditcard")
		events:
			"change .pr-creditcard-select": "updateToSelected"
			"keyup": "updateModel"

		updateToSelected: ->
			newModel = this.collection.get($(".pr-creditcard select :selected").val())
			this.model = newModel || this.model
			this.updateParent()
			this.render()

		updateParent: ->
			this.parentModel.set "credit_card", this.model
			this.parentModel.trigger "change"

		updateModel:  ->
			this.model.set
				card_holder: this.$el.find('.pr-creditcard-form-cardholder').val()
				expiration_month: this.$el.find('.pr-creditcard-form-expire').val()
				expiration_year: this.$el.find('.pr-creditcard-form-expire-year').val()
				number: this.$el.find('.pr-creditcard-form-number').val()
			this.updateParent()

		initialize: (options) ->
			options ?= {}
			this.model = new CreditCard
			this.parentModel = options.parentModel
			this.collection = new CreditCardCollection
			this.collection.fetch success: =>
				this.model = this.collection.first()
				this.updateToSelected()
			this.updateParent()
			return 


		template: Handlebars.compile $("#pr-creditcard").html()
		templateForm: Handlebars.compile $("#pr-creditcard-form").html()

		render: ->
			# save selection
			selected = $(".pr-creditcard select :selected").val()
			this.$el.html this.template
				cards: this.collection.toJSON()

			if selected == "new"
				this.$el.append(this.templateForm())

			#restore selection
			$(".pr-creditcard select [value=#{selected}]").attr("selected","selected")
			return