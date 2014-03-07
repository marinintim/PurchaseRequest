define "Collections/Address",
["Models/Address","Models/Country","Collections/Country"],
(Address,Country,CountryCollection) ->
	AddressCollection = Backbone.Collection.extend
		url: "http://localhost:3000" + "/addresses"
		model: Address