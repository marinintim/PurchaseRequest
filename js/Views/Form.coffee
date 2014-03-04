define "Views/Form",
["Models/PurchaseRequest",
 "Models/Address",
 "Models/CreditCard"
 "Views/Address",
 "Views/CreditCard",
],
(PurchaseRequest,Address,CreditCard,AddressView,CreditCardView) ->
	Form = Backbone.View.extend {
		initialize: ->

			this.creditCardView = new CreditCardView {model: this.model.creditCard}
			this.shippingView = new AddressView {model: this.model.shippingAddress}
			this.billingView = new AddressView {model: this.model.billingAddress}
			this.render()

		template: Handlebars.compile $(".pr-form").html()
		render: ->
			this.creditCardView.render()
			this.shippingView.render()
			this.billingView.render()
	}