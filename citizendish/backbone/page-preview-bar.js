(function() {
  var Base, Collection, View;

  Base = CitizenDish.Modules['backbone-base'];

  Collection = Base.Collection.extend({
    model: CitizenDish.Modules['page-preview']
  });

  View = Backbone.View.extend({
    _Collection: Collection,
    id: 'page-previews',
    tagName: 'section',
    initialize: function(options) {
      var horizontal_wrapper, model_type, models,
        _this = this;
      models = [];
      model_type = CitizenDish.Modules['page-preview'].Model;
      models.push(new model_type({
        id: 1
      }));
      models.push(new model_type({
        id: 2
      }));
      models.push(new model_type({
        id: 3
      }));
      models.push(new model_type({
        id: 4
      }));
      horizontal_wrapper = $("<div class='horizontal-scroll-wrapper'></div>");
      this.$el.append(horizontal_wrapper);
      console.log('page preview bar', this.collection);
      return _.each(models, function(model) {
        var view;
        view = new CitizenDish.Modules['page-preview'].View({
          model: model
        });
        return horizontal_wrapper.append(view.render().el);
      });
    }
  });

  CitizenDish.Modules['page-preview-bar'] = {
    Collection: Collection,
    View: View
  };

}).call(this);
