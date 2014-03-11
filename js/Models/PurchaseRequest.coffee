define "Models/PurchaseRequest",
["Models/Address","Models/CreditCard"],
(Address, CreditCard) -> 
	PurchaseRequest = Backbone.Model.extend
		attributes: 
			credit_card: CreditCard
			address: Address
			billing_address: Address
		url: ->
			"http://localhost:3000" + "/orders"
		toJSON: ->
			credit_card_id = this.get('credit_card')?.get('id')
			billing_address_id = this.get('billingAddress')?.get('id')
			address_id = this.get('address')?.get('id')
			credit_card = this.get('credit_card')?.toJSON()
			address = this.get('address')?.toJSON()
			billing_address = this.get('billing_address')?.toJSON()
			billing_address ?= address

			return {
				credit_card_id: credit_card_id
				billing_address_id: billing_address_id
				address_id: address_id
				credit_card: credit_card
				address: address
				billing_address: billing_address
			}
		validate: ->
			cardInvalid = this.get('credit_card')?.validate()
			shippingInvalid = this.get('address')?.validate()
			billingInvalid = this.get('billing_address')?.validate()

			return cardInvalid if cardInvalid
			return shippingInvalid if shippingInvalid
			return billingInvalid if billingInvalid

		###Simple debug for Backbone.sync
		sync: (method, model) ->
			console.log('sync in action')
			console.log(JSON.stringify(model))
		###