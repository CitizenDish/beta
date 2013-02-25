(function() {
  var Base, Model, View;

  Base = CitizenDish.Modules['backbone-base'];

  Model = Base.Model.extend({
    defaults: {
      'background-color': 'transparent',
      'width': '100%',
      'height': '100%',
      'left': 0,
      'top': 0
    },
    after_initialize: function(options) {
      if (options == null) {
        options = {};
      }
      if (options['image-source'] != null) {
        return this.set({
          type: 'image'
        });
      } else if (options['text'] != null) {
        return this.set({
          type: 'text'
        });
      } else {
        return this.set({
          type: 'rectangle'
        });
      }
    }
  });

  View = Base.View.extend({
    _Model: Model,
    className: 'design-element item',
    tagName: 'figure',
    after_initialize: function(options) {
      var image_source,
        _this = this;
      this.$el.css(this.model.toJSON());
      if (this.model.get('type') === 'image') {
        image_source = this.model.get('image-source');
        this.$el.attr('src', image_source);
      } else if (this.model.get('type') === 'text') {
        this.$el.html(this.model.get('text'));
        this.$el.attr('contenteditable', true);
      }
      this.$el.attr('draggable', false);
      return this.model.on('change', function(evt) {
        return _this.$el.css(_this.model.toJSON());
      });
    }
  });

  CitizenDish.Modules['design-element'] = {
    Model: Model,
    View: View
  };

}).call(this);
