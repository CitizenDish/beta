(function() {
  var Base, MEDIA_ITEM_COUNT, Mediator, Model, View;

  MEDIA_ITEM_COUNT = -1;

  Base = CitizenDish.Modules['backbone-base'];

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
      _.bindAll;
      this.model || (this.model = new Model);
      id = ++MEDIA_ITEM_COUNT;
      this.id = "media-item-preview-" + id;
      this.$el.attr('id', this.id);
      return this.$el.attr('draggable', true);
    },
    render: function() {
      var id, item;
      id = this.model.get('id');
      item = {};
      if (MEDIA_ITEM_COUNT < 2) {
        item = CitizenDish.Page['design-element-palette'].model.text();
      } else if (MEDIA_ITEM_COUNT > 11) {
        item = CitizenDish.Page['design-element-palette'].model.video();
      } else {
        item = CitizenDish.Page['design-element-palette'].model.image();
      }
      this.model.set({
        item: item.model
      });
      return this.$el.html(item.render().el);
    }
  });

  Mediator = (function() {

    function Mediator() {
      this.construct_subjects();
    }

    Mediator.prototype.construct_subjects = function() {
      this.model || (this.model = new Model);
      this.view || (this.view = new View({
        model: this.model
      }));
      this.view.model = this.model;
      return {
        view: this.view,
        model: this.model
      };
    };

    return Mediator;

  })();

  CitizenDish.Modules['user-media-item'] = {
    Model: Model,
    View: View,
    Mediator: Mediator
  };

}).call(this);
