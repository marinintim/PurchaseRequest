define "Models/Country",
["Config"],
(Config) -> 
	Region = Backbone.Model.extend
		attributes:
			code: ""
			name: ""

	RegionCollection = Backbone.Collection.extend
		model: Region
		url: ->
			Config.baseURL + "/countries/" + this.countryCode + "/regions"
		initialize: (options) ->
			this.countryCode = options.code
		fetch: ->
			if localStorage["regions_#{this.countryCode}"]?
				this.reset JSON.parse localStorage["regions_#{this.countryCode}"]	
			else
				this.sync "read",this, success: (res) =>
					localStorage["regions_#{this.countryCode}"] = JSON.stringify res
					this.reset(res)

	Country = Backbone.Model.extend
		attributes:
			code: ""
			country: ""
		initialize: (options) ->
			this.regions = new RegionCollection code: this.attributes.code
			this.regions.fetch()