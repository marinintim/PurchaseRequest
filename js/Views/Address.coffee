define "Views/Address",
["Models/Address","Collections/Address","Collections/Country"],
(Address,AddressCollection,CountryCollection) ->
	AddressView = Backbone.View.extend {
		events:
			"change .pr-address-select": "render"
			"change .pr-address-country": "updateRegions"
		initialize: ->
			this.model = new Address
			this.collection = new AddressCollection
			

			this.countryCollection = new CountryCollection
			this.countryCollection.fetch success:=>
					#this.countryCollection.models[0].regions.fetch()			

			this.collection.fetch({success:_.bind(this.render, this)})
			return

		template: Handlebars.compile $("#pr-address").html()
		templateForm: Handlebars.compile $("#pr-address-form").html()
		templateOptions: Handlebars.compile $("#pr-address-options").html()
		updateRegions: ->
			searchCode = this.$el.find('.pr-address-country').val()
			regions = this.countryCollection.findWhere({code: searchCode})?.regions.models
			this.$el.children('.pr-address-regions').html this.templateOptions options: regions
			return

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
