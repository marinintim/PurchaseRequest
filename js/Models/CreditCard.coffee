define "Models/CreditCard",
-> 
	CreditCard = Backbone.Model.extend {
		attributes: 
			number: ""
			cardholder: ""
			expiration_month: ""
			expiration_year: ""

		validate: (attributes) ->
			# credit card number validation?
			expire_date = Date.parse(+ attributes.expiration_month + "/1/" + attributes.expiration_year)
			today_date = Date()
			return "Already expired credit card!" if expire_date - today_date <= 0

			return

	}

