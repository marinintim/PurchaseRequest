// Generated by CoffeeScript 1.4.0
(function() {

  define("Models/Address", ['Models/Nested'], function(NestedModel) {
    var Address;
    return Address = NestedModel.extend({
      defaults: {
        address: "",
        address2: "",
        locality: "",
        country: "",
        region: ""
      },
      validate: function(attributes) {
        var _temp;
        if ((_temp = this.isEmpty())) {
          return "Address form is incomplete: " + _temp;
        }
      }
    });
  });

}).call(this);
