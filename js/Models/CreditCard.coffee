define "Models/CreditCard",
-> 

	CreditCard = Backbone.Model.extend
		attributes: 
			number: ""
			cardholder: ""
			expiration_month: ""
			expiration_year: ""

		validate: (attributes) ->
			# credit card number validation?
			expire_date = Date.parse(+ attributes.expiration_month + "/1/" + attributes.expiration_year)
			today_date = Date()
			attributes.number = attributes.number.split(" ").join("")
			checkNumber = (number) ->
				length = number.length
				luhn = (number) ->
					ccard = (0 for [0..number.length])
					i = 0
					sum = 0

					(ccard[i] = i) for i in ccard				
					(ccard[i] = ccard[i] * 2
					ccard[i] = ccard[i] - 9 if ccard[i] > 9) for i in ccard by 2
					
					sum = ccard.reduce (x,y) -> x+y
					(sum % 10) == 0

				#Visa
				if (number[0] == '4' && (number.length == 13 || number.length == 16))
						return luhn(number)

				#Mastercard
				if (number[0] == '5' && number.length == 16 && (number[1] == '1' || number[1] == '5'))
					return luhn(number)

				else
					return false
				
			


			return "Invalid number (not a number)" if !parseInt(attributes.number)
			
			return "Invalid number (not VISA or Mastercard)" if !checkNumber(attributes.number)
			
			return "Already expired credit card!" if expire_date - today_date <= 0
			
	window.CreditCard = CreditCard
	return CreditCard
