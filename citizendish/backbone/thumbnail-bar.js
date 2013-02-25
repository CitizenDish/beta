(function() {
  var Base, Model, View;

  Base = CitizenDish.Modules['backbone-base'];

  Model = Base.Model.extend({});

  View = Base.View.extend({
    _Model: Model,
    tagName: 'section',
    id: 'thumbnail-bar',
    after_initialize: function(options) {
      var media_bar, page_preview_bar;
      page_preview_bar = new CitizenDish.Modules['page-preview-bar'].View;
      media_bar = new CitizenDish.Modules['media-bar'].View;
      this.$el.append(page_preview_bar.render().el);
      return this.$el.append(media_bar.render().el);
    }
  });

  CitizenDish.Modules['thumbnail-bar'] = {
    Model: Model,
    View: View
  };

}).call(this);
