define 'Tests/spec/modelNested',
['Models/Nested'],
(NestedModel) ->
  'use strict'
  describe "Models :: Nested", ->
    it "should raise event on parent model", ->
      parentModel = {}
      _.extend parentModel, Backbone.Events
      spy = jasmine.createSpy()
      parentModel.listenTo parentModel, "change", spy
      model = new NestedModel parent: parentModel
      model.set
        "test":"data"
      expect(spy).toHaveBeenCalled()