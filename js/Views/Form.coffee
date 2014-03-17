define "Views/Form",
["Views/Address",
 "Views/CreditCard"],
(AddressView,CreditCardView) ->
	Form = Backbone.View.extend
		initialize: ->
			@creditCardView = new CreditCardView {parentModel: @model}
			@shippingView = new AddressView {el: $('.pr-address-shipping'), parentModel: @model}
			@billingView = new AddressView {el: $('.pr-address-billing'), parentModel: @model, samePossible: true}