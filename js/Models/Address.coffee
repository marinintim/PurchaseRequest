define "Models/Address",
["Models/Country"],
(Country) -> 
	Address = Backbone.Model.extend
		attributes: 
			address: ""
			address2: ""
			locality: ""
			country: ""
			region: ""
		validate: (attributes) ->
			attributes ?= @attributes
			return "Address is empty" if _.isEmpty attributes?.address
			return "Locality is empty" if _.isEmpty attributes?.locality
			return "Country is not chosen" if _.isEmpty attributes?.country
			return "Region is not chosen" if _.isEmpty attributes?.region
