define "Collections/CreditCard",
["Models/CreditCard"],
(CreditCard) ->
	CreditCardCollection = Backbone.Collection.extend
		url: "/credit_cards"
		model: CreditCard

