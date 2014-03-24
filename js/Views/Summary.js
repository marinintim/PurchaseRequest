// Generated by CoffeeScript 1.4.0
(function() {

  define("Views/Summary", function() {
    var SummaryView;
    return SummaryView = Backbone.View.extend({
      initialize: function(options) {
        return this.listenTo(this.model, "change", this.render);
      },
      template: Handlebars.compile($("#pr-summary").html()),
      render: function() {
        var _this = this;
        return _.defer(function() {
          return _this.$el.html(_this.template(_this.model.toJSON()));
        });
      }
    });
  });

}).call(this);
