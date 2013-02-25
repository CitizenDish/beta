(function() {
  var Base, Model, View;

  Base = CitizenDish.Modules['backbone-base'];

  Model = Base.Model.extend({
    defaults: {
      title: 'CitizenDish',
      name: 'new'
    }
  });

  View = Base.View.extend({
    _Model: Model,
    _template_id: 'modal',
    tagName: 'article',
    className: 'modal hide fade',
    after_initialize: function(options) {
      var name;
      name = this.model.get('name');
      return this.id = "" + name + "-modal";
    }
  });

  CitizenDish.Modules['modal'] = {
    Model: Model,
    View: View
  };

}).call(this);
