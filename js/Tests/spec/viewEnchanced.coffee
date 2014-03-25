define 'Tests/spec/viewEnchanced',
['Views/Enchanced'],
(EnchancedView) ->
  describe 'Views :: Enchanced', ->
    beforeEach ->
      @el = $ '.test'
      _model = Backbone.Model.extend
        defaults:
          'first':''
          'second':''
      _collection = Backbone.Collection.extend
        model: _model
      

      tmp_model = new _model
      tmp_model.set first: 'true', second: 'false', id: 1

      tmp_model2 = new _model
      tmp_model2.set first: 'nope', second: 'yep', id: 123

      @collection = new _collection
      @collection.reset [tmp_model, tmp_model2]
      @model = new _model

      @view = new EnchancedView
        collection: @collection
        model: @model
        el: @el

    afterEach ->
      @el.empty()

    it 'should update model to selected from list', ->
      @el.append '<select><option value="123">some</option></select>'

      @view.updateToSelected 
        target:
          value: '123'
      expect(@model.get 'first' ).toEqual 'nope'
    
    it 'should update model to inputs\' values', ->
      @el.append '<input class="test1" value="lol"><input class="test2" value="lol2">'
      @view.form = 
        'first': '.test1'
        'second': '.test2'
      @view.updateModel()
      expect(@model.get('first')).toEqual 'lol'
      expect(@model.get('second')).toEqual 'lol2'