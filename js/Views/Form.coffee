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
			this.creditCardView = new CreditCardView {parentModel: this.model}
			this.shippingView = new AddressView {el: $('.pr-address-shipping'), parentModel: this.model}
			this.billingView = new AddressView {el: $('.pr-address-billing'), parentModel: this.model, samePossible: true}
	}