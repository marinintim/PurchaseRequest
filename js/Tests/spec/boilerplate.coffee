define 'Tests/spec/',
[],
() ->
  describe '', ->
    beforeEach ->
      @el = $ '.test'
    afterEach ->
      @el.empty()
    
    it '', ->
