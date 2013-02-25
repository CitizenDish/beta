(function() {
  var Base, Mediator, Model, PAGE_COUNT, View;

  Base = CitizenDish.Modules['backbone-base'];

  PAGE_COUNT = 0;

  Model = Base.Model.extend({
    defaults: {
      pockets: [],
      style: {
        border: 0
      }
    }
  });

  View = Base.View.extend({
    _Model: Model,
    tagName: 'article',
    className: 'design-page img-polaroid',
    events: {
      'click': function() {
        return console.log('click', this);
      }
    },
    initialize: function(options) {
      return _.bindAll(this);
    },
    render: function() {
      this.$el.html("");
      this.render_pockets();
      this.$el.attr('data-page-index', ++PAGE_COUNT);
      this.$el.css(this.model.get('style'));
      return this;
    },
    render_pockets: function() {
      var pockets,
        _this = this;
      pockets = this.model.get('pockets');
      console.log('pockets', pockets);
      return _.each(pockets, function(pocket) {
        var view;
        view = pocket.view;
        return _this.$el.append(view.render().el);
      });
    }
  });

  Mediator = (function() {

    function Mediator(view, model) {
      this.view = view != null ? view : new View;
      this.model = model != null ? model : new Model;
      this.view.model = this.model;
    }

    Mediator.prototype.construct_subjects = function() {
      return this.view.render();
    };

    Mediator.prototype.set_pockets = function(pocket_collection) {
      var pockets;
      pockets = [];
      _.each(pocket_collection, function(pocket_block) {
        var pocket;
        pocket = new CitizenDish.Modules['design-pocket'].Mediator;
        pocket.set_block(pocket_block);
        return pockets.push(pocket);
      });
      this.model.set({
        pockets: pockets
      });
      return this.view.render();
    };

    Mediator.prototype.get_pockets = function() {
      return this.model.get('pockets');
    };

    return Mediator;

  })();

  CitizenDish.Modules['design-page'] = {
    Model: Model,
    View: View,
    Mediator: Mediator
  };

}).call(this);
