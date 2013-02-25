(function() {
  var Base, Model, View;

  Base = CitizenDish.Modules['backbone-base'];

  Model = Base.Model.extend({});

  View = Base.View.extend({
    tagName: 'header',
    className: 'application-logo'
  });

  CitizenDish.Modules['header'] = {
    Model: Model,
    View: View
  };

}).call(this);
