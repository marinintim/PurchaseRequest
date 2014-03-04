define "Collections/Country",
["Models/Country","Config"],
(Country,Config) ->
	CountryCollection = Backbone.Collection.extend
		model: Country
		url: ->
			Config.baseURL + "/countries"