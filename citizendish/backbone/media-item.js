(function() {
  var Model, View;

  Model = Backbone.Model.extend({});

  View = Backbone.View.extend({
    _Model: Model,
    tagName: 'figure',
    className: 'media-preview img-polaroid',
    events: {
      'mousedown': function(evt) {
        return window.dragged = this;
      },
      'mouseup': function(evt) {
        return window.dragged = void 0;
      }
    },
    initialize: function(options) {
      var id;
      this.model || (this.model = new this.__proto__._Model);
      id = ++MEDIA_ITEM_COUNT;
      this.id = "media-item-preview-" + id;
      this.$el.attr('id', this.id);
      this.$el.attr('draggable', true);
      return this.on('before render', function() {
        var item;
        item = {};
        if (id < 2) {
          item = CitizenDish.Page['design-element-palette'].model.text();
        } else if (id > 11) {
          item = CitizenDish.Page['design-element-palette'].model.video();
        } else {
          item = CitizenDish.Page['design-element-palette'].model.image();
        }
        this.model.set({
          item: item.model
        });
        return this.$el.html(item.render().el);
      });
    }
  });

  CitizenDish.Modules['media-item'] = {
    Model: Model,
    View: View
  };

}).call(this);
