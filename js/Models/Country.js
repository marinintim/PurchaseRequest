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
        return "/countries/" + this.countryCode + "/regions";
      },
      initialize: function(options) {
        return this.countryCode = options.code;
      },
      fetch: function(options) {
        var _ref,
          _this = this;
        if (options == null) {
          options = {};
        }
        if ((_ref = options.success) == null) {
          options.success = function() {};
        }
        if (localStorage["regions_" + this.countryCode] != null) {
          this.reset(JSON.parse(localStorage["regions_" + this.countryCode]));
          return options.success();
        } else {
          return this.sync("read", this, {
            success: function(res) {
              localStorage["regions_" + _this.countryCode] = JSON.stringify(res);
              _this.reset(res);
              return options.success();
            }
          });
        }
      }
    });
    return Country = Backbone.Model.extend({
      attributes: {
        code: "",
        country: ""
      },
      initialize: function(options) {
        return this.regions = new RegionCollection({
          code: this.attributes.code
        });
      }
    });
  });

}).call(this);
