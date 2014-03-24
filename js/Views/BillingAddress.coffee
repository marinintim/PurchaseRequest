define "Views/BillingAddress",
["Views/Address"],
(AddressView) ->
  billingAddressView = AddressView.extend
    updateToSelected: (event) ->
      selected = if event.target? then event.target.value else "same"
      if selected == "same"
        @model.set @shipping.toJSON()
        @listenToOnce @shipping, "change", @updateToSelected
      else
        @stopListening @shipping
        if selected == "new" then @updateModel()
        else
          @model.set newModel.toJSON() if (newModel = @collection.get(selected))
      @render(selected)

    template: Handlebars.compile $("#pr-address-billing").html()

    getReady: (options) ->
      @shipping = options.parentModel.get "address"
      @model = options.parentModel.get "billing_address"

      @listenTo @collection, "sync", =>
        @updateToSelected
          target:
            value: "same"