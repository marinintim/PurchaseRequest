define "Collections/Country",
["Models/Country"],
(Country) ->
	CountryCollection = Backbone.Collection.extend
		model: Country
		url: "http://jsonstub.com" + "/countries"
		_regionCache =
			"US": [{code:"LOL",name:"Yepaons"}]
		_loadRegions: (code) ->
			_regionCache[code] = [{code:"cache yep",name:"suoeefe"}]
		getRegions: (code) ->
			if cache[code]?
				return cache[code]
			else
				_loadRegions code
				return cache[code]