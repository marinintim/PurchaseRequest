define 'Tests/spec/modelCreditCard',
['Models/CreditCard'],
(CreditCard) ->
  'use strict'

  describe 'Models :: Nested :: Credit Card', ->
    beforeEach ->
      @cc = new CreditCard parent: _.clone(Backbone.Events)
      @myCard =
        cardholder: 'Petr Ivanov'
        number: '4111 1111 1111 1111'
        expiration_month: '1'
        expiration_year: '25'

    it 'should accept and validate properly data as correct', ->
      @cc.set @myCard
      expect(@cc.isValid()).toBeTruthy()

    it 'should return error on invalid card number', ->
      @myCard.number = '4111 1111 hacker was here'
      @cc.set @myCard
      expect(@cc.validate()).toContain 'invalid number'

    it 'should return error on expired date (month)', ->
      #getting this year, change in the next millenium
      @myCard.expiration_year = (new Date().getFullYear() - 2000).toString()

      # Date.getMonth starts counting at zero, but users (and CreditCard)
      # start counting at one, so that month is /already/ expired
      @myCard.expiration_month = (new Date().getMonth()).toString()
      @cc.set @myCard
      expect(@cc.validate()).toContain 'expired'

    it 'should return error on expired date (year)', ->
      @myCard.expiration_year = '13'
      @cc.set @myCard
      expect(@cc.validate()).toContain 'expired'

    it 'should return error on full expired year as well as short', ->
      @myCard.expiration_year = '2013'
      @cc.set @myCard
      expect(@cc.validate()).toContain 'expired'

    it 'should return error on empty card holder', ->
      @myCard.cardholder = ''
      @cc.set @myCard
      expect(@cc.validate()).toContain 'Cardholder is empty'
    return