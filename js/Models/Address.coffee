define "Models/Address",
["Models/Country"],
(Country) -> 
	Address = Backbone.Model.extend
		attributes: 
			address: ""
			address2: ""
			locality: ""
			country: Country
			region: Country.region
		validate: (attributes) ->
			attributes ?= this.attributes
			return "address is empty" unless attributes?.address
			return "locality is empty" unless !!attributes?.locality
			return "country is not chosen" unless !!attributes?.country
			return "region is not chosen" unless !!attributes?.region
