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
			if this.samePossible
				selected = this.$el.find(".pr-address-select :selected").val()
				if selected != "new"
					newModel = this.collection.get(this.$el.find(".pr-address-select :selected").val())
					this.model = newModel || this.model
				else
					this.model = new Address	
			else
				newModel = this.collection.get(this.$el.find(".pr-address-select :selected").val())
				this.model = newModel || this.model
			this.updateParent()
			this.render()

		updateParent: ->
			console.log 'changing'
			this.parentModel.set "#{if (this.options.samePossible == true) then "billing" else "shipping"}Address", this.model
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
			this.model.set('country',this.$el.find('.pr-address-country :selected').val())
			searchCode = this.model.get('country')
			regions = this.countryCollection.findWhere({code: searchCode})?.get('regions').toJSON()
			
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
			this.countryCollection.fetch reset: true, success: =>
				this.updateRegions

			this.collection.fetch success: =>
				$('.pr-address-select option:first').attr("selected","selected")
				this.updateToSelected()
				return

			return

		template: Handlebars.compile $("#pr-address").html()
		templateForm: Handlebars.compile $("#pr-address-form").html()
		templateOptions: Handlebars.compile $("#pr-address-options").html()
		

		render: ->
			selected = this.$el.find(".pr-address-select :selected").val()

			this.$el.html this.template({addresses: this.collection.toJSON(), samePossible: this.options.samePossible})

			if selected == "new"
				this.$el.append this.templateForm countries: this.countryCollection.toJSON()
				this.updateRegions()
			this.$el.find(".pr-address-select [value=#{selected}]").attr("selected","selected")
			return

	}
