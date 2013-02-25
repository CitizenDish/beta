(function() {
  var Base, Mediator, Model, View;

  Base = CitizenDish.Modules['backbone-base'];

  Model = Base.Model.extend({});

  View = Base.View.extend({
    _Model: Model,
    tagName: 'section',
    id: 'design-area',
    load: function(views) {
      var view, _i, _len, _results;
      _results = [];
      for (_i = 0, _len = views.length; _i < _len; _i++) {
        view = views[_i];
        _results.push(this.$el.append(view.render().el));
      }
      return _results;
    },
    after_initialize: function(options) {}
  });

  Mediator = (function() {

    function Mediator() {}

    Mediator.prototype.construct_subjects = function() {
      var mediator, _i, _len, _ref;
      this.view = new View;
      this.model = this.view.model;
      this.design_canvas = new CitizenDish.Modules['design-canvas'].Mediator;
      this.design_page_collection = new CitizenDish.Modules['design-page-collection'].Mediator;
      this.user_media_previews = new CitizenDish.Modules['user-media-collection'].Mediator;
      _ref = [this.design_canvas, this.design_page_collection, this.user_media_previews];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        mediator = _ref[_i];
        mediator.construct_subjects();
      }
      this.view.load([this.design_page_collection.view, this.user_media_previews.view, this.design_canvas.view]);
      this.design_page_collection.preview_on(this.design_canvas);
      return {
        model: this.model,
        view: this.view
      };
    };

    Mediator.prototype.get_components = function() {
      return {
        'design-page-collection': this.design_page_collection,
        'user-media-collection': this.user_media_previews,
        'design-canvas': this.design_canvas
      };
    };

    return Mediator;

  })();

  CitizenDish.Modules['design-area'] = {
    Model: Model,
    View: View,
    Mediator: Mediator
  };

}).call(this);
