(function() {
  var Base, Model, View;

  Base = CitizenDish.Modules['backbone-base'];

  Model = Base.Model.extend({
    defaults: {}
  });

  View = Base.View.extend({
    _Model: Model
  });

  CitizenDish.Modules['canvas-events'] = {
    Model: Model,
    View: View
  };

}).call(this);
