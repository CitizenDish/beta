(function() {
  var Base, Model, View;

  Base = CitizenDish.Modules['backbone-base'];

  Model = Base.Model.extend({
    defaults: {}
  });

  View = Base.View.extend({
    _Model: Model,
    after_initialize: function(options) {}
  });

  CitizenDish.Modules['design-component-configuration'] = {
    Model: Model,
    View: View
  };

}).call(this);
