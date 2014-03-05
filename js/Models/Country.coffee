define "Models/Country",
-> 
	Region = Backbone.Model.extend
		attributes:
			code: ""
			name: ""
	RegionCollection = Backbone.Collection.extend
		model: Region
		url: ->
			"http://jsonstub.com" + "/countries/" + this.countryCode + "/regions"
		initialize: (options) ->
			this.countryCode = options.code

	Country = Backbone.Model.extend
		attributes:
			code: ""
			country: ""
		initialize: (options) ->
			this.attributes.regions = new RegionCollection code: this.attributes.code
			this.attributes.regions.fetch()
	return Country