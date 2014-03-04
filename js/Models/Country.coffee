define "Models/Country",
-> 
	Country = Backbone.Model.extend
		collection: CountryCollection
		attributes:
			code: ""
			regions: {}
			


	CountryCollection = Backbone.Collection.extend
		model: Country

	RegionsCollection = 
		"US": "lol"
		
	return Country