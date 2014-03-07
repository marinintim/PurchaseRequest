// Generated by CoffeeScript 1.4.0
(function() {

  define("Models/Country", function() {
    var Country, Region, RegionCollection;
    Region = Backbone.Model.extend({
      attributes: {
        code: "",
        name: ""
      }
    });
    RegionCollection = Backbone.Collection.extend({
      model: Region,
      url: function() {
        return "http://localhost:3000" + "/countries/" + this.countryCode + "/regions";
      },
      initialize: function(options) {
        return this.countryCode = options.code;
      },
      fetch: function() {
        if (localStorage["regions_" + this.countryCode] == null) {
          localStorage["regions_" + this.countryCode] = JSON.stringify(this.sync("read", this));
        }
        return JSON.parse(localStorage["regions_" + this.countryCode]);
      }
    });
    window.RC = RegionCollection;
    Country = Backbone.Model.extend({
      attributes: {
        code: "",
        country: ""
      },
      initialize: function(options) {
        this.regions = new RegionCollection({
          code: this.attributes.code
        });
        return this.regions.fetch();
      }
    });
    return Country;
  });

}).call(this);
