define "Models/PurchaseRequest",
["Models/Address","Models/CreditCard"],
(Address, CreditCard) -> 
	PurchaseRequest = Backbone.Model.extend
		defaults:
			credit_card: new CreditCard
			address: new Address
			billing_address: new Address

		url: "/orders"
		toJSON: ->
			return {
				credit_card_id: @get('credit_card')?.get('id')
				billing_address_id: @get('billingAddress')?.get('id')
				address_id: @get('address')?.get('id')
				credit_card: @get('credit_card')?.toJSON()
				address: @get('address')?.toJSON()
				billing_address: @get('billing_address')?.toJSON() || @get('address')?.toJSON()
			}
		validate: ->
			cardInvalid = @get('credit_card')?.validate()
			shippingInvalid = @get('address')?.validate()
			billingInvalid = @get('billing_address')?.validate()

			return cardInvalid if cardInvalid
			return shippingInvalid if shippingInvalid
			return billingInvalid if billingInvalid