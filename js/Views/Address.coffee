define "Views/Address",
["Models/Address","Collections/Address","Collections/Country"],
(Address,AddressCollection,CountryCollection) ->
	AddressView = Backbone.View.extend {
		events:
			"change .pr-address-select": "updateToSelected"
			"change .pr-address-country": "updateRegions"
			"change input": "updateModel"

		updateToSelected: ->
			newModel = this.collection.get(this.$el.find(".pr-address-select :selected").val())
			console.log this.model
			this.model = newModel || this.model
			console.log this.model
			this.render()

		updateParent: ->
			this.parentModel.set("#{if (this.options.samePossible == true) then "billing" else "shipping"}Address",this.model)
			console.log 'updating pr from address'

		updateModel:  ->
			this.model.set
				address: this.$el.find('.pr-address-address').val()
				address2: this.$el.find('.pr-address-address2').val()
				locality: this.$el.find('.pr-address-locality').val()
				country: this.$el.find('.pr-address-country').val()
				region: this.$el.find('.pr-address-region').val()
			console.log 'updating address'

		updateRegions: ->
			searchCode = this.$el.find('.pr-address-country').val()
			regions = this.countryCollection.findWhere({code: searchCode})?.regions.models
			this.$el.children('.pr-address-regions').html '<option>S00KA</OPTION>'
			return



		initialize: (options) ->
			options ?= {}
			this.options = options

			this.model = new Address
			this.parentModel = options.parentModel
			this.collection = new AddressCollection
			

			this.countryCollection = new CountryCollection
			this.countryCollection.fetch success:=>
					#this.countryCollection.models[0].regions.fetch()			

			this.collection.fetch({success:_.bind(this.render, this)})

			this.listenTo this.model, "change", _.bind this.updateParent, this
			return

		template: Handlebars.compile $("#pr-address").html()
		templateForm: Handlebars.compile $("#pr-address-form").html()
		templateOptions: Handlebars.compile $("#pr-address-options").html()
		

		render: ->
			selected = this.$el.find(".pr-address-select :selected").val()
			
			console.log "rendering #{this.$el.className}"
			#console.log JSON.stringify this.collection
			#console.log JSON.stringify this.countryCollection
			this.$el.html this.template({addresses: this.collection.toJSON()})

			if selected == "new"
				this.$el.append this.templateForm countries: this.countryCollection.toJSON()
				this.updateRegions()
			this.$el.find(".pr-address-select [value=#{selected}]").attr("selected","selected")
			return

	}
