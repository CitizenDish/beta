(function() {
  var Base, Collection, View;

  Base = CitizenDish.Modules['backbone-base'];

  Collection = Base.Collection.extend({
    initialize: function(options) {
      return this.__proto__.model = CitizenDish.Modules['media-item'].Model;
    }
  });

  View = Backbone.View.extend({
    _Collection: Collection,
    id: 'media-previews',
    tagName: 'section',
    initialize: function(options) {
      var horizontal_wrapper, index, model_type, models, _i,
        _this = this;
      models = [];
      model_type = CitizenDish.Modules['media-item'].Model;
      for (index = _i = 1; _i <= 13; index = ++_i) {
        models.push(new model_type({
          id: index
        }));
      }
      horizontal_wrapper = $("<div class='horizontal-scroll-wrapper'></div>");
      this.$el.append(horizontal_wrapper);
      return _.each(models, function(model) {
        var view;
        view = new CitizenDish.Modules['media-item'].View({
          model: model
        });
        return horizontal_wrapper.append(view.render().el);
      });
    }
  });

  CitizenDish.Modules['media-bar'] = {
    Collection: Collection,
    View: View
  };

}).call(this);
