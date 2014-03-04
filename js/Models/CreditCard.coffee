define "Models/CreditCard",
-> 
	CreditCard = Backbone.Model.extend {
		attributes: 
			number: ""
			cardholder: ""
			expires: ""
		defaults:
			number: "1234123412341234"
			cardholder: "Ivan Ivanov"
			expires: "2034/12"


	}

