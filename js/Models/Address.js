// Generated by CoffeeScript 1.4.0
(function() {

  define("Models/Address", ["Models/Country"], function(Country) {
    var Address;
    return Address = Backbone.Model.extend({
      attributes: {
        address: "",
        address2: "",
        locality: "",
        country: "",
        region: ""
      },
      validate: function(attributes) {
        var name, returnMessage, value;
        if (attributes == null) {
          attributes = this.attributes;
        }
        returnMessage = "";
        for (name in attributes) {
          value = attributes[name];
          if (_.isEmpty(value) && name !== 'address2') {
            returnMessage += "" + (name[0].toUpperCase() + name.slice(1)) + " is empty. ";
          }
        }
        if (returnMessage.length > 0) {
          return "address is incomplete: " + returnMessage;
        }
      }
    });
  });

}).call(this);
