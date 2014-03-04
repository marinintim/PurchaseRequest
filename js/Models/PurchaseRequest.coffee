define "Models/PurchaseRequest",
["Models/Address","Models/CreditCard"],
(Address, CreditCard) -> 
	PurchaseRequest = Backbone.Model.extend
		attributes: 
			creditCard: CreditCard
			shippingAddress: Address
			billingAddress: Address
		url: ->
			"http://jsonstub.com" + "/orders"
		toJSON: ->
			return {
				creditCard: this.attributes.creditCard?.toJSON()
				shippingAddress: this.attributes.shippingAddress?.toJSON()
				billingAddress: this.attributes.billingAddress?.toJSON()
			}