define 'Tests/spec/viewAddress',
['Views/Address'],
(AddressView) ->
  describe 'Views :: Enchanced :: Address', ->
    beforeEach ->
      @el = $ '.test'
      _model = Backbone.Model.extend
        defaults:
          'address': new Backbone.Model

      @res = []
      for i in [1..10] by 1
        tmp = {}
        for prop in ['address','address2','country','region','locality']
          tmp[prop] = "#{i} #{prop}"
        @res.push tmp
      

      @collection = new (Backbone.Collection.extend model: _model)
      
      window.app = 
        collections:
          addresses: @collection

      @parentModel = new _model

      @view = new AddressView
        el: @el
        parentModel: @parentModel

      @collection.reset @res
    afterEach ->
      @el.empty()

    it 'should initialize model with first model from collection', ->
      # @collection.reset triggers reset, so we need 
      # trigger "sync" manually
      @collection.trigger "sync"
      expect(@parentModel.get('address').toJSON()).toEqual @collection.first().toJSON()