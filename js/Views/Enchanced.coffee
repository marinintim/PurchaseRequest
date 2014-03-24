define "Views/Enchanced",
->
  EnchancedView = Backbone.View.extend

    updateToSelected: (event) ->
      selected = event.target.value
      if selected == "new"
        @updateModel()
      else
        @model.set newModel.toJSON() if (newModel = @collection.get(selected))
      @render(selected)

    updateModel:  ->
      newAttrs = {}
      for attr, selector of @form
        newAttrs[attr] = @$el.find(selector).val()
      @model.set newAttrs
      @model.unset "id"