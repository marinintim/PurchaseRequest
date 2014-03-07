define "Collections/Country",
["Models/Country"],
(Country) ->
	CountryCollection = Backbone.Collection.extend
		model: Country
		url: "http://localhost:3000" + "/countries"