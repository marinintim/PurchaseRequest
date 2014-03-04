define "Models/PurchaseRequest",
["Models/Address","Models/CreditCard"],
(Address, CreditCard) -> 
	PurchaseRequest = Backbone.Model.extend {
		attributes: 
			creditCard: CreditCard
			shippingAddress: Address
			billingAddress: Address
		defaults:
			creditCard: new CreditCard {"cardholder":"Petr",expires:"never",number:"123456789765"}
			shippingAddress: new Address {address:"Lenina, 3",address2:"kv 2",locality:"Moon",country:"US",region:"CA"}
			billingAddress: new Address {address:"Lenina, 3",address2:"kv 2",locality:"Moon",country:"US",region:"CA"}
	}