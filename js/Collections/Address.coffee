define "Collections/Address",
["Models/Address","Models/Country","Collections/Country"],
(Address,Country,CountryCollection) ->
	AddressCollection = Backbone.Collection.extend
		url: "/addresses"
		model: Address