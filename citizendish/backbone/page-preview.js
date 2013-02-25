(function() {
  var Model, View;

  Model = Backbone.Model.extend({});

  View = Backbone.View.extend({
    _Model: Model,
    tagName: 'article',
    className: 'page-preview img-polaroid',
    events: {
      'click': function() {
        var design_canvas, page_copy;
        design_canvas = CitizenDish.Page['design-canvas-mediator'];
        design_canvas.model.set({
          page_index: this.model.get('id')
        });
        page_copy = $(design_canvas.current_page().clone());
        page_copy.id = '';
        page_copy.css({
          width: 0,
          height: 0,
          overflow: 'visible'
        });
        return this.$el.html(page_copy);
      }
    },
    initialize: function(options) {
      var id;
      this.model || (this.model = new this.__proto__._Model);
      id = this.model.get('id');
      this.id = "page-preview-" + id;
      this.$el.attr('id', this.id);
      return this.$el.attr('data-preview-page-index', id);
    }
  });

  CitizenDish.Modules['page-preview'] = {
    Model: Model,
    View: View
  };

}).call(this);
