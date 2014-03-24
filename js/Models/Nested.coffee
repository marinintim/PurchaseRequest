define "Models/Nested",
->
  NestedModel = Backbone.Model.extend
    initialize: (options) ->
      options ?= {}
      @parent = options.parent || undefined
    set: (attrs, options) ->
      if @parent? then @parent.trigger "change"
      Backbone.Model.prototype.set.call(@,attrs,options)
    isEmpty: ->
      error = ""
      for name, value of @attributes
        if _.isEmpty(value) and (name != 'id' and name != 'address2')
          beautiful_name = name.replace("_"," ")
          beautiful_name = beautiful_name[0].toUpperCase() + beautiful_name.slice(1)
          error += "#{beautiful_name} is empty. "
      if error.length > 0 then return error.trim()
      return