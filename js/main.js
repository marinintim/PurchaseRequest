// Generated by CoffeeScript 1.4.0
(function() {

  require(['Models/PurchaseRequest', 'Views/Address', 'Views/BillingAddress', 'Views/CreditCard', 'Views/Summary', 'Views/Error', 'Views/Send', 'Collections/Address', 'Collections/Country', 'Collections/CreditCard'], function(PurchaseRequest, AddressView, BillingAddressView, CreditCardView, SummaryView, ErrorView, SendView, AddressCollection, CountryCollection, CreditCardCollection) {
    var Router;
    window.app = {};
    Router = Backbone.Router.extend({
      routes: {
        "*default": "default"
      },
      "default": function() {
        app.model = new PurchaseRequest;
        app.collections = {
          addresses: new AddressCollection,
          countries: new CountryCollection,
          cards: new CreditCardCollection
        };
        _.each(app.collections, function(c) {
          return c.fetch();
        });
        app.views = {};
        app.views.summary = new SummaryView({
          el: $('.pr-summary'),
          model: app.model
        });
        app.views.error = new ErrorView({
          el: $('.pr-error'),
          model: app.model
        });
        app.views.send = new SendView({
          el: $('.pr-send'),
          model: app.model
        });
        app.views.creditCard = new CreditCardView({
          el: $('.pr-creditcard'),
          parentModel: app.model
        });
        app.views.shipping = new AddressView({
          el: $('.pr-address-shipping'),
          parentModel: app.model
        });
        return app.views.billing = new BillingAddressView({
          el: $('.pr-address-billing'),
          parentModel: app.model
        });
      }
    });
    app.router = new Router;
    $.ajax("/regions/state", {
      success: function(res) {
        if (res > (localStorage[regionsVersion] || 0)) {
          localStorage.clear();
          return localStorage[regionsVersion] = res;
        }
      }
    });
    Backbone.history.start();
  });

}).call(this);
