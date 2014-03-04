define "Collections/Address",
["Models/Address","Models/Country","Collections/Country"],
(Address,Country,CountryCollection) ->
	AddressCollection = Backbone.Collection.extend
		url: "http://jsonstub.com" + "/addresses"
		model: Address