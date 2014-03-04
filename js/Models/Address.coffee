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
		
	
	