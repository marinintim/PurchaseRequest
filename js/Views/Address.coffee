define "Views/Address",
["Views/Enchanced"],
(EnchancedView) ->
  AddressView = EnchancedView.extend
    events:
      "change .pr-address-select": "updateToSelected"
      "change .pr-address-country": "updateRegions"
      "change .pr-address-region": "updateModel"
      "keyup input": "updateModel"

    updateRegions: (event) ->
      @model.set('country',newCountry) if (newCountry = event?.target?.value or @model.get('country') or @$('.pr-address-country option:first').val())
      success = =>
        @$('.pr-address-region').html @templateOptions options: countryModel.regions.toJSON()
        @updateModel()
      countryModel.regions.fetch success: success if countryModel = @countryCollection.findWhere code: newCountry    
      return

    getReady: (options) ->
      @model = options.parentModel.get "address"
      @listenToOnce @collection, "sync", =>
        if @collection.size() > 0
          @model.set @collection.first().toJSON()
          @updateToSelected 
            target:
              value: @model.id
          return  


    initialize: (options) ->
      options ?= {}
      @form = {}
      for prop in ['address','address2','locality','country','region']
        @form[prop] = '.pr-address-' + prop
      @collection = app.collections.addresses
      @countryCollection = app.collections.countries
      @getReady options
      return
           


    template: Handlebars.compile $("#pr-address").html()
    templateForm: Handlebars.compile $("#pr-address-form").html()
    templateOptions: Handlebars.compile $("#pr-address-options").html()
    

    render: (selected) ->
      selected ?= @$('.pr-address-select').val()
      @$el.html @template addresses: @collection.toJSON()
      
      if selected == "new"
        @$el.append @templateForm countries: @countryCollection.toJSON()
        @updateRegions()
      
      @$('.pr-address-select').val(selected)
      return