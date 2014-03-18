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
			if this.isNew()
				return "Credit card fields are not filled" if _.isEmpty attributes
				return "Credit card: card number is empty" if _.isEmpty attributes.number
				return "Credit card: cardholder is empty" if _.isEmpty attributes.card_holder
				return "Credit card: expiration date is incomplete" if _.isEmpty attributes.expiration_month or _.isEmpty attributes.expiration_year

				return "Credit card: invalid number" unless /^[0-9]+$/.test attributes.number.replace /[\s-\\\/]+/g, ""
				return "Credit card: invalid expiration month" unless $.isNumeric attributes.expiration_month
				return "Credit card: invalid expiration year" unless $.isNumeric attributes.expiration_year

				expire_date = new Date()
				expire_date.setDate 1
				expire_date.setFullYear 2000 + parseInt attributes.expiration_year, 10
				expire_date.setMonth + parseInt attributes.expiration_month, 10
				
				today_date = new Date()
				window.expire = expire_date
				console.log expire_date - today_date
				return "Credit card is already expired" if expire_date - today_date <= 0

	return CreditCard
