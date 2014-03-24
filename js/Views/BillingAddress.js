// Generated by CoffeeScript 1.4.0
(function() {

  define("Views/BillingAddress", ["Views/Address"], function(AddressView) {
    var billingAddressView;
    return billingAddressView = AddressView.extend({
      updateToSelected: function(event) {
        var newModel, selected;
        selected = event.target != null ? event.target.value : "same";
        if (selected === "same") {
          this.model.set(this.shipping.toJSON());
          this.listenToOnce(this.shipping, "change", this.updateToSelected);
        } else {
          this.stopListening(this.shipping);
          if (selected === "new") {
            this.updateModel();
          } else {
            if ((newModel = this.collection.get(selected))) {
              this.model.set(newModel.toJSON());
            }
          }
        }
        return this.render(selected);
      },
      template: Handlebars.compile($("#pr-address-billing").html()),
      getReady: function(options) {
        var _this = this;
        this.shipping = options.parentModel.get("address");
        this.model = options.parentModel.get("billing_address");
        return this.listenTo(this.collection, "sync", function() {
          return _this.updateToSelected({
            target: {
              value: "same"
            }
          });
        });
      }
    });
  });

}).call(this);
