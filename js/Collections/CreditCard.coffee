define "Collections/CreditCard",
["Models/CreditCard"],
(CreditCard) ->
	CreditCardCollection = Backbone.Collection.extend
		url: "http://localhost:3000" + "/credit_cards"
		model: CreditCard

