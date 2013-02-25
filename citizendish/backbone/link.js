(function() {
  var Base, Model, View;

  Base = CitizenDish.Modules['backbone-base'];

  Model = Base.Model.extend({
    defaults: {
      'data-attributes': {
        'toggle': 'modal',
        'target': '#modal',
        'title': 'tooltip-title',
        'delay': '100',
        'placement': 'right'
      },
      value: 'link'
    },
    initialize: function(options) {
      var data_attributes, value;
      if (options == null) {
        options = {};
      }
      data_attributes = _.extend({}, this.get('data-attributes'));
      data_attributes.target = "#" + options.name + "-modal";
      data_attributes.title = options['short_description'];
      value = options.display || options.name;
      return this.set({
        value: value,
        'data-attributes': data_attributes
      });
    }
  });

  View = Base.View.extend({
    _Model: Model,
    tagName: 'a',
    events: {
      'click': function(evt) {
        return CitizenDish.Page['design-canvas'].trigger(this.model.get('value'));
      }
    },
    after_initialize: function(options) {
      var _this = this;
      this.$el.html(this.model.get('value'));
      return _.map(this.model.get('data-attributes'), function(value, key) {
        return _this.$el.attr("data-" + key, value);
      });
    }
  });

  CitizenDish.Modules['link'] = {
    Model: Model,
    View: View
  };

}).call(this);
