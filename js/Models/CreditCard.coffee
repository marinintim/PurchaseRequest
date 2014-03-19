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
				returnMessage = ""
				for name, value of attributes
					if _.isEmpty value
						beautiful_name = name.replace("_"," ")
						beautiful_name = beautiful_name[0].toUpperCase() + beautiful_name.slice(1)
						returnMessage += "#{beautiful_name} is empty. "
				if returnMessage.length > 0 then return "Credit card form is incomplete: #{returnMessage.trim()}"
				
				return "Credit card: invalid number" unless /^[0-9]+$/.test attributes.number.replace /[\s-\\\/]+/g, ""
				return "Credit card: invalid expiration month" unless $.isNumeric attributes.expiration_month
				return "Credit card: invalid expiration year" unless $.isNumeric attributes.expiration_year

				expire_date = new Date()
				expire_date.setDate 1
				expire_date.setFullYear 2000 + parseInt attributes.expiration_year, 10
				expire_date.setMonth + parseInt attributes.expiration_month, 10
				
				today_date = new Date()
				window.expire = expire_date
				return "Credit card is already expired" if expire_date - today_date <= 0

	return CreditCard
