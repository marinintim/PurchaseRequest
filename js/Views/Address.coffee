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
			if selected == "same"
				newModel = this.parentModel.get('address')
			else 
				newModel = this.collection.get(selected)
			
			this.model.set(newModel.toJSON()) if newModel?
			this.parentModel.trigger "change"
			this.render()

		updateModel:  ->
			this.model.set
				id: "" 
				address: this.$el.find('.pr-address-address').val()
				address2: this.$el.find('.pr-address-address2').val()
				locality: this.$el.find('.pr-address-locality').val()
				country: this.$el.find('.pr-address-country').val()
				region: this.$el.find('.pr-address-region').val()
			this.parentModel.trigger "change"

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

			this.parentModel = options.parentModel
			this.model = this.parentModel.get "#{if this.options.samePossible then "billing_" else ""}address"

			this.collection = new AddressCollection
			window.collection = this.collection

			this.countryCollection = new CountryCollection
			

			this.collection.fetch success: =>
				if this.options.samePossible
					this.listenTo this.parentModel.get('address'), "change", =>
						this.model.set this.parentModel.get('address').toJSON()
				else
					newModel = this.collection.first()
					this.model.set newModel.toJSON()
				this.updateToSelected()
				return

			this.countryCollection.fetch()

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
