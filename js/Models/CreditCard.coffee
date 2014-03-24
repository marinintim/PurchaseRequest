define "Models/CreditCard",
['Models/Nested'],
(NestedModel) -> 

	CreditCard = NestedModel.extend
		defaults: 
			number: ""
			cardholder: ""
			expiration_month: ""
			expiration_year: ""
		validate: (attributes) ->
			attributes ?= @attributes
			if @isNew()
				isExpired = (m,y) ->
					expire_date = new Date()
					expire_date.setDate 1
					# if year is bigger than two-digits, then parse it as full year, otherwise complete to 20xx
					expire_date.setFullYear  if (_temp = parseInt y, 10) > 99 then _temp else _temp + 2000
					expire_date.setMonth parseInt m, 10
					today_date = new Date()
					return expire_date - today_date <= 0

				return "Credit card form is incomplete: #{_temp}" if (_temp = @isEmpty())				
				return "Credit card form: invalid number" unless /^[0-9]+$/.test attributes.number.replace /[\s-\\\/]+/g, ""
				return "Credit card form: invalid expiration month" unless $.isNumeric attributes.expiration_month
				return "Credit card form: invalid expiration year" unless $.isNumeric attributes.expiration_year
				return "Credit card form: card is already expired" if isExpired(attributes.expiration_month,attributes.expiration_year)