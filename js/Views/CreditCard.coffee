define "Views/CreditCard",
["Models/CreditCard","Collections/CreditCard"],
(CreditCard, CreditCardCollection) ->
  CreditCardView = Backbone.View.extend 
    el: $(".pr-creditcard")
    events:
      "change .pr-creditcard-select": "updateToSelected"
      "keyup": "updateModel"

    updateToSelected: ->
    	selected = $(".pr-creditcard select :selected").val()
    	if selected == "new"
    		@updateModel()
    	else
	      newModel = @collection.get(selected)
	      if newModel?
	     	  @model.set newModel.toJSON() 
	        @parentModel.trigger "change"
	    @render()


    updateModel:  ->
      @model.set
        card_holder: @$el.find('.pr-creditcard-form-cardholder').val()
        expiration_month: @$el.find('.pr-creditcard-form-expire').val()
        expiration_year: @$el.find('.pr-creditcard-form-expire-year').val()
        number: @$el.find('.pr-creditcard-form-number').val()
      @model.unset "id"
      @parentModel.trigger "change"

    initialize: (options) ->
      options ?= {}

      @parentModel = options.parentModel
      @model = @parentModel.get("credit_card")

      @collection = new CreditCardCollection
      @collection.fetch success: =>
        if @collection.size() > 0
          @model.set @collection.first().toJSON()
          setTimeout =>
          	@$el.find(".pr-creditcard-select [value=#{@model.id}]").attr("selected","selected")
          ,0
        @updateToSelected()
      return 


    template: Handlebars.compile $("#pr-creditcard").html()
    templateForm: Handlebars.compile $("#pr-creditcard-form").html()

    render: ->
      # save selection
      selected = @$el.find(".pr-creditcard-select").val()
      @$el.html @template
        cards: @collection.toJSON()

      if selected == "new"
        @$el.append(@templateForm())

      #restore selection
      $(".pr-creditcard select [value=#{selected}]").attr("selected","selected")
      return