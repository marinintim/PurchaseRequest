define "Models/CreditCard",
-> 

	CreditCard = Backbone.Model.extend
		attributes: 
			number: ""
			cardholder: ""
			expiration_month: ""
			expiration_year: ""

		validate: (attributes) ->
			attributes ?= @attributes

			return "Credit card fields are not filled" if _.isEmpty attributes
			return "Credit card: expiration date is incomplete" if _.isEmpty attributes.expiration_month or _.isEmpty attributes.expiration_year
			return "Credit card: card number is empty" if _.isEmpty attributes.number
			return "Credit card: cardholder is empty" if _.isEmpty attributes.card_holder

			
			number = parseInt(@attributes.number.split(" ").join(""),10)


			expire_date = new Date("#{attributes.expiration_month}/1/#{attributes.expiration_year}")
			expire_date.setMonth expire_date.getMonth + 1

			today_date = new Date()

			return "Already expired credit card!" if expire_date - today_date <= 0

	return CreditCard
