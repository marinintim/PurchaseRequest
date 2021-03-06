// Generated by CoffeeScript 1.4.0
(function() {

  define('Tests/spec/viewSummary', ['Views/Summary'], function(SummaryView) {
    return describe('Views :: Summary', function() {
      beforeEach(function() {
        this.el = $('.test');
        this.model = new (Backbone.Model.extend({
          defalts: {
            'a': '3'
          }
        }));
        return this.view = new SummaryView({
          model: this.model,
          el: this.el
        });
      });
      afterEach(function() {
        return this.el.empty();
      });
      return it('should render, when model has been changed', function() {
        var _this = this;
        spyOn(this.view, 'render');
        return this.model.set({
          a: '4',
          success: function() {
            return expect(_this.view.render).toHaveBeenCalled();
          }
        });
      });
    });
  });

}).call(this);
