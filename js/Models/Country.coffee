define "Models/Country",
-> 
	Region = Backbone.Model.extend
		attributes:
			code: ""
			name: ""
	RegionCollection = Backbone.Collection.extend
		model: Region
		url: ->
			"http://localhost:3000" + "/countries/" + this.countryCode + "/regions"
		initialize: (options) ->
			this.countryCode = options.code
		fetch: ->
			localStorage["regions_#{this.countryCode}"] = JSON.stringify this.sync("read",this) unless localStorage["regions_#{this.countryCode}"]?
			return JSON.parse localStorage["regions_#{this.countryCode}"]
	window.RC = RegionCollection

	Country = Backbone.Model.extend
		attributes:
			code: ""
			country: ""
		initialize: (options) ->
			this.regions = new RegionCollection code: this.attributes.code
			this.regions.fetch()
		#toJSON: ->
		#	return this.get('country')
	return Country