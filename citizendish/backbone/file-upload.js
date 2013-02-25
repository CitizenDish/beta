(function() {
  var Base, Model, View;

  Base = CitizenDish.Modules['backbone-base'];

  Model = Base.Model.extend({
    defaults: {}
  });

  View = Base.View.extend({
    _Model: Model,
    after_initialize: function(options) {
      return $('#media-previews').fileupload({
        dataType: 'json',
        done: function(evt, data) {
          return console.log('done', evt, data);
        },
        drop: function(evt, data) {
          return console.log('drop', evt, data);
        }
      });
    }
  });

  CitizenDish.Modules['file-upload'] = {
    Model: Model,
    View: View
  };

  $(function() {
    var funcc;
    funcc = function() {
      return new View;
    };
    return setTimeout(funcc, 1000);
  });

}).call(this);
