define "Collections/CreditCard",
["Models/CreditCard","Config"],
(CreditCard, Config) ->
	CreditCardCollection = Backbone.Collection.extend
		url: ->
			Config.baseURL + "/credit_cards"
		model: CreditCard

