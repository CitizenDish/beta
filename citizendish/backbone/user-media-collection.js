(function() {
  var Base, Mediator, Model, View;

  Base = CitizenDish.Modules['backbone-base'];

  Model = Base.Model.extend({
    defaults: function() {
      return {
        items: (function() {
          var _i, _results;
          _results = [];
          for (_i = 0; _i <= 11; _i++) {
            _results.push(new CitizenDish.Modules['user-media-item'].Mediator);
          }
          return _results;
        })()
      };
    }
  });

  View = Base.View.extend({
    _Model: Model,
    tagName: 'figure',
    className: 'user-media-collection horizontal-scroll',
    after_initialize: function(options) {}
  });

  Mediator = (function() {

    function Mediator() {}

    Mediator.prototype.construct_subjects = function() {
      var horizontal_scroll_wrapper, items,
        _this = this;
      this.model = new Model;
      this.view = new View({
        model: this.model
      });
      items = this.items();
      horizontal_scroll_wrapper = $("<div class='horizontal-scroll-wrapper'></div>'");
      _.each(items, function(item) {
        item.construct_subjects();
        item.view.render();
        return horizontal_scroll_wrapper.append(item.view.el);
      });
      this.view.$el.html(horizontal_scroll_wrapper);
      return {
        view: this.view,
        model: this.model
      };
    };

    Mediator.prototype.items = function() {
      return this.model.get('items');
    };

    return Mediator;

  })();

  CitizenDish.Modules['user-media-collection'] = {
    Model: Model,
    View: View,
    Mediator: Mediator
  };

}).call(this);
