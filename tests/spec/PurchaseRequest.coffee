describe "my awesome purchase requset app", ->
	describe "validation", ->
		it "should discard expired credit card data", ->
			credit_card = new App.CreditCard {expired_month:2,expired_year:2013,card_holder:"Chelyabinsk Metheorite"}
			expect credit_card.validate()
				.toBeFalsy()
			
		
		it "should discard credit card with month > 12", ->
			credit_card = new App.CreditCard {expired_month:13,expired_year:2014,card_holder:"Premium User"}
			expect credit_card.validate()
				.toBeFalsy()


		it "should accept credit card which doesn't expire", ->
			credit_card = new App.CreditCard {expired_month:Date().getMonth(), expired_year:Date().getFullYear(),card_holder:"Evergreen"}
			expect credit_card.validate()
				.toBeTruthy()

		it "should discard address if region does not belong to country", ->
			address = new App.Address {address: "Sadovaya 25, 3", country:"USA", region: "SPB", locality:"Saint-Petersburg"}
			expect address.validate()
				.toBeFalsy()