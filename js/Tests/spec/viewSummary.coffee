define 'Tests/spec/viewSummary',
['Views/Summary'],
(SummaryView) ->
  describe 'Views :: Summary', ->
    beforeEach ->
      @el = $ '.test'
      @model = new (Backbone.Model.extend defalts: 'a': '3')
      @view = new SummaryView
        model: @model
        el: @el
        
    afterEach ->
      @el.empty()

    it 'should render, when model has been changed', ->
      spyOn @view, 'render'
      @model.set a: '4', success: =>
        expect(@view.render).toHaveBeenCalled()