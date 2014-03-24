require [
 'Models/PurchaseRequest',
 'Views/Address',
 'Views/BillingAddress'
 'Views/CreditCard',
 'Views/Summary',
 'Views/Error',
 'Views/Send',
 'Collections/Address',
 'Collections/Country',
 'Collections/CreditCard'
 ],
(PurchaseRequest,
 AddressView,
 BillingAddressView,
 CreditCardView,
 SummaryView, 
 ErrorView,
 SendView,
 AddressCollection,
 CountryCollection,
 CreditCardCollection) ->
  window.app = {}

  Router = Backbone.Router.extend
    routes:
      "*default":          "default"

    default: ->
      app.model = new PurchaseRequest
      app.collections = 
        addresses: new AddressCollection
        countries: new CountryCollection
        cards: new CreditCardCollection
      _.each app.collections, (c) -> c.fetch()

      app.views = {}
      app.views.summary = new SummaryView
        el: $ '.pr-summary'
        model: app.model

      app.views.error = new ErrorView
        el: $ '.pr-error'
        model: app.model

      app.views.send = new SendView
        el: $ '.pr-send'
        model: app.model

      app.views.creditCard = new CreditCardView
        el: $ '.pr-creditcard'
        parentModel: app.model

      app.views.shipping = new AddressView 
        el: $ '.pr-address-shipping'
        parentModel: app.model

      app.views.billing = new BillingAddressView
        el: $ '.pr-address-billing'
        parentModel: app.model
  
  app.router = new Router


  $.ajax "/regions/state", success: (res) ->
    if res > (localStorage[regionsVersion] or 0) 
      localStorage.clear()
      localStorage[regionsVersion] = res
  
  Backbone.history.start()
  return