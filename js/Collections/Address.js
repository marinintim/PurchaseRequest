// Generated by CoffeeScript 1.4.0
(function() {

  define("Collections/Address", ["Models/Address", "Models/Country", "Collections/Country"], function(Address, Country, CountryCollection) {
    var AddressCollection;
    return AddressCollection = Backbone.Collection.extend({
      url: "http://localhost:3000" + "/addresses",
      model: Address
    });
  });

}).call(this);
