define "Collections/Address",
["Models/Address"],
(Address) ->
	AddressCollection = Backbone.Collection.extend
		url: "/addresses"
		model: Address