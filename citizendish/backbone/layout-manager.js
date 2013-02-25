(function() {
  var Base, Mediator, Model, View;

  Base = CitizenDish.Modules['backbone-base'];

  Model = Base.Model.extend({
    defaults: {},
    build_layout: function(id) {
      if (id == null) {
        id = void 0;
      }
      if (!(id != null) || !(this[id] != null)) {
        return this.default_layout();
      }
      return this[id]();
    },
    create_page_collection_mediator: function() {
      var page_collection_mediator;
      page_collection_mediator = new CitizenDish.Modules['design-page-collection'].Mediator;
      page_collection_mediator.reset_pages();
      return page_collection_mediator;
    },
    black: function() {
      return [];
    },
    asphalt: function() {
      var first_page, fourth_page, page_collection, second_page, third_page;
      page_collection = this.create_page_collection_mediator();
      first_page = page_collection.create_page();
      first_page.set_pockets([
        {
          top: 65,
          left: 0,
          width: 1024,
          height: 644
        }
      ]);
      second_page = page_collection.create_page();
      second_page.set_pockets([
        {
          top: 65,
          left: 36,
          width: 351,
          height: 569
        }, {
          top: 65,
          left: 413,
          width: 579,
          height: 569
        }
      ]);
      third_page = page_collection.create_page();
      third_page.set_pockets([
        {
          top: 65,
          left: 36,
          width: 295,
          height: 170
        }, {
          top: 65,
          left: 367,
          width: 295,
          height: 170
        }, {
          top: 65,
          left: 698,
          width: 295,
          height: 170
        }, {
          top: 278,
          left: 36,
          width: 295,
          height: 170
        }, {
          top: 278,
          left: 367,
          width: 295,
          height: 170
        }, {
          top: 278,
          left: 698,
          width: 295,
          height: 170
        }, {
          top: 491,
          left: 36,
          width: 295,
          height: 170
        }, {
          top: 491,
          left: 367,
          width: 295,
          height: 170
        }, {
          top: 491,
          left: 698,
          width: 295,
          height: 170
        }
      ]);
      fourth_page = page_collection.create_page();
      fourth_page.set_pockets([
        {
          top: 65,
          left: 36,
          width: 295,
          height: 170
        }, {
          top: 65,
          left: 367,
          width: 295,
          height: 170
        }, {
          top: 278,
          left: 36,
          width: 295,
          height: 170
        }, {
          top: 278,
          left: 367,
          width: 295,
          height: 170
        }, {
          top: 491,
          left: 36,
          width: 295,
          height: 170
        }, {
          top: 491,
          left: 367,
          width: 295,
          height: 170
        }, {
          top: 65,
          left: 698,
          width: 295,
          height: 595
        }
      ]);
      return page_collection;
    },
    default_layout: function() {
      var first_page, page_collection, second_page, third_page;
      page_collection = this.create_page_collection_mediator();
      first_page = page_collection.create_page();
      first_page.set_pockets([
        {
          top: 34,
          left: 0,
          width: 1024,
          height: 700
        }
      ]);
      second_page = page_collection.create_page();
      second_page.set_pockets([
        {
          top: 200,
          left: 200,
          width: 500,
          height: 600
        }
      ]);
      third_page = page_collection.create_page();
      third_page.set_pockets([
        {
          top: 30,
          left: 90,
          width: 50,
          height: 660
        }, {
          top: 30,
          left: 790,
          width: 150,
          height: 660
        }
      ]);
      return page_collection;
    }
  });

  View = Base.View.extend({});

  Mediator = (function() {

    function Mediator(view, model) {
      this.view = view != null ? view : new View;
      this.model = model != null ? model : new Model;
      this.view.model = this.model;
      CitizenDish.ActiveInstances['layout-manager'] = this;
    }

    Mediator.prototype.build_layout = function(id) {
      return this.model.build_layout(id || "*");
    };

    return Mediator;

  })();

  CitizenDish.Modules['layout-manager'] = {
    Model: Model,
    View: View,
    Mediator: Mediator
  };

}).call(this);
