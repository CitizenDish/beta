(function() {
  var Base, Model, View;

  Base = CitizenDish.Modules['backbone-base'];

  Model = Base.Model.extend({
    defaults: {
      elements: [],
      current_element: void 0
    },
    after_initialize: function(options) {
      this.timer = new CitizenDish.Modules['timer'](this.on_timer_expire, this);
      this.timer.interval = 3000;
      this.timer.start();
      return this.on('change:elements', function(value) {
        return this.set({
          current_element: value
        });
      });
    },
    begin_timer: function() {
      return this.timer.start();
    },
    on_timer_expire: function() {
      return console.log('timer went off', this);
    },
    stop_timer: function() {
      return this.timer.stop();
    }
  });

  View = Base.View.extend({
    _Model: Model,
    children_views: [],
    tagName: 'figure',
    after_initialize: function(options) {
      return this.model.on('change:current_element', function(evt) {
        var current_value, previous_value;
        console.log('current element changed', evt, this);
        previous_value = evt.previous;
        current_value = evt.changed;
        this.children_views[previous_value].hide();
        return this.children_views[value].show();
      });
    }
  });

  CitizenDish.Modules['design-slideshow'] = {
    Model: Model,
    View: View
  };

}).call(this);
