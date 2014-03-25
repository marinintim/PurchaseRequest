define 'Tests/spec/viewSend',
["Views/Send"],
(SendView) ->
  describe 'Views :: Send', ->
    beforeEach ->
      @el = $ '.test'
      @model = new Backbone.Model

      @view = new SendView
        model: @model
        el: @el
    afterEach ->
      @el.empty()
    it 'should disable el, if error’s status is 500', ->
      @model.trigger 'error', @model, status: 500
      expect(@el.attr 'disabled').toEqual 'disabled'