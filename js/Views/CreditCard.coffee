define "Views/CreditCard",
["Models/CreditCard","Collections/CreditCard"],
(CreditCard, CreditCardCollection) ->
	CreditCardView = Backbone.View.extend 
		el: $(".pr-creditcard")
		events:
			"change": "render"
		initialize: ->
			this.model = new CreditCard
			this.collection = new CreditCardCollection
			this.collection.fetch({success:_.bind(this.render, this)})


		template: Handlebars.compile $("#pr-creditcard").html()
		templateForm: Handlebars.compile $("#pr-creditcard-form").html()

		render: ->
			# save selection
			selected = $(".pr-creditcard select :selected").val()
			console.log JSON.stringify this.collection
			this.$el.html this.template
				cards: this.collection.toJSON()

			if selected == "new"
				this.$el.append(this.templateForm())

			#restore selection
			$(".pr-creditcard select [value=#{selected}]").attr("selected","selected")
			return