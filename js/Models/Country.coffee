define "Models/Country",
-> 
	Region = Backbone.Model.extend
		attributes:
			code: ""
			name: ""
	RegionCollection = Backbone.Collection.extend
		model: Region
		url: ->
			"http://jsonstub.com" + "/countries/" + this.attributes.code + "/regions"
	Country = Backbone.Model.extend
		attributes:
			code: ""
			country: ""
		regions: RegionCollection
	return Country