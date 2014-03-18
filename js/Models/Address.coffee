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
			returnMessage = ""
			for name, value of attributes
				if _.isEmpty(value) and name != 'address2'
					returnMessage += "#{name[0].toUpperCase() + name.slice(1)} is empty. "
			if returnMessage.length > 0 then return "address is incomplete: #{returnMessage}"