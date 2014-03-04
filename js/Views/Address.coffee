define "Views/Address",
["Models/Address"],
(Address) ->
	AddressView = Backbone.View.extend {
		initialize: ->
			this.model = Address
			return

		template: Handlebars.compile($("#pr-address").html())

		render: ->
			this.$el.html this.template()
			return

	}
