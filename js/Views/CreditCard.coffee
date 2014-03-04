define "Views/CreditCard",
["Models/CreditCard","Collections/CreditCard"],
(CreditCard, CreditCardCollection) ->
	CreditCardView = Backbone.View.extend 
		el: $(".pr-creditcard")
		events:
			"change .pr-creditcard-select": "updateToSelected"
			"change input": "updateModel"

		updateToSelected: ->
			newModel = this.collection.get($(".pr-creditcard select :selected").val())
			this.model = newModel || this.model
			this.render()

		updateParent: ->
			this.parentModel.set("creditCard",this.model)
			console.log 'updating pr from cc'

		updateModel:  ->
			this.model.set
				card_holder: this.$el.find('#pr-creditcard-form-cardholder').val()
				expiration_month: this.$el.find('#pr-creditcard-form-expire').val()
				expiration_year: this.$el.find('#pr-creditcard-form-expire-year').val()
				number: this.$el.find('#pr-creditcard-form-number').val()
			console.log 'updating credit card model'

		initialize: (options) ->
			options ?= {}
			this.model = new CreditCard
			this.parentModel = options.parentModel
			this.collection = new CreditCardCollection
			this.collection.fetch({success:_.bind(this.render, this)})			
			this.listenTo this.model, "change", _.bind this.updateParent, this
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