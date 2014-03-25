define 'Tests/spec/viewCreditCard',
['Views/CreditCard'],
(CreditCardView) ->
  describe 'Views :: Enchanced :: CreditCard', ->
    beforeEach ->
      @el = $ '.test'
      _parentModel = Backbone.Model.extend
        defaults:
          'credit_card': new Backbone.Model
      @parentModel = new _parentModel

      @res = []
      for i in [1..10] by 1
        tmp = {}
        for prop in ['number','cardholder','expiration_month','expiration_year']
          tmp[prop] = "#{i} #{prop}"
        @res.push tmp
      
      @collection = new (Backbone.Collection.extend model: _parentModel)
      
      window.app = 
        collections:
          cards: @collection
      @view = new CreditCardView
        el: @el
        parentModel: @parentModel
      @collection.reset @res

    afterEach ->
      @el.empty()

    it 'should initialize model with first model from collection', ->
      @collection.trigger "sync"
      expect(@parentModel.get('credit_card').toJSON()).toEqual @collection.first().toJSON()