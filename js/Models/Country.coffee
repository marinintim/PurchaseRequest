define "Models/Country",
-> 
	Region = Backbone.Model.extend
		attributes:
			code: ""
			name: ""

	RegionCollection = Backbone.Collection.extend
		model: Region
		url: ->
			"/countries/" + @countryCode + "/regions"
		initialize: (options) ->
			@countryCode = options.code
		fetch: (options) ->
			options ?= {}
			options.success ?= ->
				return
			if localStorage["regions_#{@countryCode}"]?
				@reset JSON.parse localStorage["regions_#{@countryCode}"]
				options.success()
			else
				@sync "read",this, success: (res) =>
					localStorage["regions_#{@countryCode}"] = JSON.stringify res
					@reset(res)
					options.success()

	Country = Backbone.Model.extend
		attributes:
			code: ""
			country: ""
		initialize: (options) ->
			@regions = new RegionCollection code: @attributes.code