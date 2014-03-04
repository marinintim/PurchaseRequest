define "Models/CreditCard",
-> 

	CreditCard = Backbone.Model.extend
		attributes: 
			number: ""
			cardholder: ""
			expiration_month: ""
			expiration_year: ""

		validate: (attributes) ->
			attributes ?= this.attributes
			return "Credit card fields are not filled" unless attributes
			return "Credit card: expiration date is incomplete" unless attributes.expiration_month and attributes.expiration_year
			return "Credit card: card number is empty" unless attributes.number
			return "Credit card: cardholder is empty" unless attributes.card_holder

			# credit card number validation?
			
			number = parseInt(this.attributes.number.split(" ").join(""),10)
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
				
			

			# server does not return numbers
			#return "Invalid number (not a number)" if !parseInt(number)
			
			#but if user gives us full number, we can check it
			return "Invalid number (not VISA or Mastercard)" if parseInt(number) and !checkNumber(attributes.number)
			
			expire_date = Date.parse("#{attributes.expiration_month}/1/#{attributes.expiration_year}")
			today_date = new Date()
			return "Already expired credit card!" if expire_date - today_date <= 0

	return CreditCard
