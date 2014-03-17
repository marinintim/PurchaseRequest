define "Collections/Country",
["Models/Country"],
(Country) ->
	CountryCollection = Backbone.Collection.extend
		model: Country
		url: "/countries"