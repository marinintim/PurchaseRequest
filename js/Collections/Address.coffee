define "Collections/Address",
["Models/Address","Models/Country","Collections/Country","Config"],
(Address,Country,CountryCollection,Config) ->
	AddressCollection = Backbone.Collection.extend
		url: ->
			Config.baseURL + "/addresses"
		model: Address