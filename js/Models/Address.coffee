define "Models/Address",
['Models/Nested'],
(NestedModel) -> 
	Address = NestedModel.extend
		defaults: 
			address: ""
			address2: ""
			locality: ""
			country: ""
			region: ""
		validate: (attributes) ->
			return "Address form is incomplete: #{_temp}" if (_temp = @isEmpty())