define 'Tests/spec/modelCountry',
['Models/Country'],
(Country) ->
  describe 'Models :: Country', ->
    beforeEach ->
      localStorage.clear()
      @model = new Country
      @res = []
      @res.push
        code: "lol"
        name: "lolregion"
      @res.push
        code: "some"
        name: "someregion"
      @model.regions.sync = (action, obj, options) =>
        
        options.success @res
          
    it 'should return lists of regions', ->
      @model.regions.fetch()
      expect(@model.regions.toJSON()).toEqual @res

    it 'should access server only once (use cache)', ->
      spyOn(@model.regions, 'sync').and.callThrough()
      @model.regions.fetch()
      @model.regions.fetch()
      expect(@model.regions.sync.calls.count()).toEqual 1