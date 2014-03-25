define 'Tests/spec/modelAddress',
['Models/Address'],
(Address) ->
  'use strict'
  describe "Models :: Nested :: Address", ->
    beforeEach ->
      @a = new Address
      @myAddr =
        address: 'Tverskaya st.'
        address2: '57, flat 14'
        locality: 'Tomsk'
        country: 'Russia'
        region: 'TOM'
    it 'should accept and validate properly data as correct', ->
      @a.set @myAddr
      expect(@a.isValid()).toBeTruthy()

    it 'should return error on completely empty address object', ->
      expect(@a.validate()).toBeDefined()

    it 'should return error on empty address', ->
      @myAddr.address = ''
      @a.set @myAddr
      expect(@a.validate()).toContain "Address is empty"

    it 'should return error on empty locality', ->
      @myAddr.locality = ''
      @a.set @myAddr
      expect(@a.validate()).toContain "Locality is empty"