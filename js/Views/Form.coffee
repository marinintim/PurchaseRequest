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
			this.shippingView = new AddressView {el: $('.pr-address-shipping'), model: this.model.shippingAddress}
			this.billingView = new AddressView {el: $('.pr-address-billing'), model: this.model.billingAddress, samePossible: true}

		template: Handlebars.compile $(".pr-form").html()
		render: ->
	}