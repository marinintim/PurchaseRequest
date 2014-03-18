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
			selected = @$el.find(".pr-address-select :selected").val()
			if selected == "same"
				newModel = @parentModel.get('address')
				@model.set @parentModel.get('address').toJSON()
				@listenTo @parentModel.get('address'), "change", =>
					@model.set @parentModel.get('address').toJSON()
					@parentModel.trigger "change"
			else
				if selected == "new"
					@stopListening @parentModel.get('address')
					@updateModel()
				else
					newModel = @collection.get(selected)
					@model.set(newModel.toJSON()) if newModel?
			@parentModel.trigger "change"
			@render()

		updateModel:  ->
			for param in ['address','address2','locality','country','region']
				@model.set param, @.$el.find(".pr-address-#{param}").val() || ""
			@model.unset "id"
			@parentModel.trigger "change"

		updateRegions: ->
			newCountry = @$el.find('.pr-address-country :selected').val()
			newCountry ?= @model.get('country')
			@model.set('country',newCountry) if newCountry != undefined

			countryModel = @countryCollection.findWhere(code: newCountry)
			if countryModel?.regions?
				countryModel.regions.fetch success: =>				
					@$el.find('.pr-address-region').html @templateOptions options: countryModel.regions.toJSON()
					@updateModel()
			return

		initialize: (options) ->
			options ?= {}
			@options = options
			@options.samePossible ?= false

			@parentModel = options.parentModel
			@model = @parentModel.get "#{if @options.samePossible then "billing_" else ""}address"

			@collection = new AddressCollection

			@countryCollection = new CountryCollection
			

			@collection.fetch success: =>
				if @options.samePossible
					setTimeout =>
						@model.set @parentModel.get('address').toJSON()
						@$el.find(".pr-address-select [value=same]").attr("selected","selected")
						@updateToSelected()
					,0
					@listenTo @parentModel.get('address'), "change", =>
						@model.set @parentModel.get('address').toJSON()
						@parentModel.trigger "change"
				else
					if @collection.size() > 0
						@model.set @collection.first().toJSON()
						setTimeout =>
							@$el.find(".pr-address-select [value=#{@model.get('id')}]").attr("selected","selected")
						,0
						@parentModel.trigger "change"
				@updateToSelected()
				return

			@countryCollection.fetch success: _.bind(@updateRegions,this)

			return

		template: Handlebars.compile $("#pr-address").html()
		templateForm: Handlebars.compile $("#pr-address-form").html()
		templateOptions: Handlebars.compile $("#pr-address-options").html()
		

		render: ->
			selected = @$el.find(".pr-address-select :selected").val()
			@$el.html @template addresses: @collection.toJSON(), samePossible: @options.samePossible

			if selected == "new"
				@$el.append @templateForm countries: @countryCollection.toJSON()
				@updateRegions()
			@$el.find(".pr-address-select [value=#{selected}]").attr("selected","selected")
			return

	}
