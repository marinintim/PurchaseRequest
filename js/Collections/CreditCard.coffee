define "Collections/CreditCard",
["Models/CreditCard"],
(CreditCard) ->
	CreditCardCollection = Backbone.Collection.extend
		url: "http://jsonstub.com" + "/credit_cards"
		model: CreditCard

