define "Views/CreditCard",
["Views/Enchanced"],
(EnchancedView) ->
  CreditCardView = EnchancedView.extend
    events:
      "change .pr-creditcard-select": "updateToSelected"
      "keyup": "updateModel"


    initialize: (options) ->
      options ?= {}
      @form =
        'cardholder': 'cardholder'
        'expiration_month': 'expire'
        'expiration_year': 'expire-year'
        'number': 'number'

      for key of @form
        @form[key] = '.pr-creditcard-form-' + @form[key]

      @model = options.parentModel?.get("credit_card")

      @collection = app.collections.cards
      @listenToOnce @collection, "sync", =>
        if @collection.size() > 0
          @model.set @collection.first().toJSON()
          @updateToSelected
            target:
              value: @model.id
      return 


    template: Handlebars.compile $("#pr-creditcard").html()
    templateForm: Handlebars.compile $("#pr-creditcard-form").html()

    render: (selected) ->
      selected ?= @$(".pr-creditcard-select").val()
      @$el.html @template cards: @collection.toJSON()
      if selected == "new"
        @$el.append @templateForm()
      @$('.pr-creditcard-select').val(selected)
      return