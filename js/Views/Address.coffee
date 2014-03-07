define "Views/Address",
["Models/Address","Collections/Address","Collections/Country"],
(Address,AddressCollection,CountryCollection) ->
	AddressView = Backbone.View.extend {
		events:
			"change .pr-address-select": "updateToSelected"
			"change .pr-address-country": "updateRegions"
			"change .pr-address-region": "updateModel"
			"keyup": "updateModel"
		

		updateToSelected: ->
			selected = this.$el.find(".pr-address-select :selected").val()
				
			newModel = this.collection.get(selected)
			
			this.model = newModel || this.model
			console.log
			this.updateParent()
			this.render()

		updateParent: ->
			this.parentModel.set "#{if (this.options.samePossible == true) then "billing_" else "" }address", this.model
			this.parentModel.trigger("change")

		updateModel:  ->
			this.model.set
				id: ""
				address: this.$el.find('.pr-address-address').val()
				address2: this.$el.find('.pr-address-address2').val()
				locality: this.$el.find('.pr-address-locality').val()
				country: this.$el.find('.pr-address-country').val()
				region: this.$el.find('.pr-address-region').val()
			this.updateParent()

		updateRegions: ->
			newCountry = this.$el.find('.pr-address-country :selected').val()
			newCountry ?= this.model.get('country')
			this.model.set('country',newCountry) if newCountry != undefined

			regions = this.countryCollection.findWhere(code: newCountry).regions.toJSON()
			
			this.$el.find('.pr-address-region').html this.templateOptions {options: regions}
			this.updateModel()
			return regions

		

		initialize: (options) ->
			options ?= {}
			this.options = options
			this.options.samePossible ?= false
			this.model = new Address

			this.parentModel = options.parentModel
			this.collection = new AddressCollection
			

			this.countryCollection = new CountryCollection
			

			this.collection.fetch success: =>
				this.model = this.collection.first()
				this.updateToSelected()
				return

			this.countryCollection.fetch success: =>
				this.updateRegions

			return

		template: Handlebars.compile $("#pr-address").html()
		templateForm: Handlebars.compile $("#pr-address-form").html()
		templateOptions: Handlebars.compile $("#pr-address-options").html()
		

		render: ->
			selected = this.$el.find(".pr-address-select :selected").val()
			this.$el.html this.template addresses: this.collection.toJSON(), samePossible: this.options.samePossible

			if selected == "new"
				this.$el.append this.templateForm countries: this.countryCollection.toJSON()
				this.updateRegions()
			this.$el.find(".pr-address-select [value=#{selected}]").attr("selected","selected")
			return

	}
