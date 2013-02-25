(function() {
  var Base, Mediator, Model, View;

  Base = CitizenDish.Modules['backbone-base'];

  Model = Base.Model.extend({
    defaults: function() {
      var active_page, cover, layout_name, pages;
      pages = [new CitizenDish.Modules['design-page'].Mediator];
      cover = pages[0];
      active_page = cover;
      layout_name = '';
      return {
        pages: pages,
        cover: cover,
        active_page: active_page,
        layout_name: layout_name
      };
    },
    add_page: function(page) {
      var pages;
      pages = this.get('pages');
      pages.push(page);
      if (pages.length === 1) {
        return this.set({
          cover: page,
          active_instance: page
        });
      }
    }
  });

  View = Base.View.extend({
    tagName: 'section',
    className: 'design-page-collection',
    render: function() {
      var pages, scroll_wrapper;
      scroll_wrapper = $("<div class='horizontal-scroll-wrapper'></div>'");
      this.$el.html(scroll_wrapper);
      pages = this.model.get('pages');
      console.log('pages', pages);
      _.each(pages, function(page_mediator) {
        var view;
        view = page_mediator.view;
        view.render();
        return scroll_wrapper.append(view.el);
      });
      return this;
    }
  });

  Mediator = (function() {

    function Mediator(view, model) {
      this.view = view;
      this.model = model;
      if (!(this.model != null)) {
        this.model = new Model;
      }
      if (!(this.view != null)) {
        this.view = new View({
          model: this.model
        });
      }
      CitizenDish.ActiveInstances['design-page-collection'] = this;
      this.view.model = this.model;
    }

    Mediator.prototype.construct_subjects = function() {
      this.load_layout();
      this.view.render();
      return {
        view: this.view,
        model: this.model
      };
    };

    Mediator.prototype.load_layout = function() {
      var layout_manager, layout_name, result;
      layout_name = this.model.get('layout_name');
      layout_manager = CitizenDish.ActiveInstances['layout-manager'] || new CitizenDish.Modules['layout-manager'].Mediator;
      result = layout_manager.build_layout(layout_name);
      console.log('result', result);
      return this.set_pages(result.get_pages());
    };

    Mediator.prototype.get_pages = function() {
      return this.model.get('pages');
    };

    Mediator.prototype.set_pages = function(page_mediators) {
      return this.model.set({
        pages: page_mediators,
        cover: page_mediators[0]
      });
    };

    Mediator.prototype.page_count = function() {
      return this.model.get('pages').length;
    };

    Mediator.prototype.cover = function() {
      return this.model.get('cover');
    };

    Mediator.prototype.create_page = function() {
      return this.add_new();
    };

    Mediator.prototype.add_new = function(page) {
      if (!(page != null)) {
        page = new CitizenDish.Modules['design-page'].Mediator;
      }
      this.model.add_page(page);
      return page;
    };

    Mediator.prototype.reset_pages = function() {
      return this.model.set({
        pages: []
      });
    };

    Mediator.prototype.set_cover_to_index = function(index) {
      var cover, pages;
      if (index == null) {
        index = 0;
      }
      pages = this.get('pages');
      cover = pages[index];
      return this.model.set({
        cover: cover
      });
    };

    Mediator.prototype.active_page = function() {
      var page;
      return page = this.get_pages()[0];
    };

    Mediator.prototype.preview_on = function(design_canvas) {
      return design_canvas.load(this.active_page());
    };

    return Mediator;

  })();

  CitizenDish.Modules['design-page-collection'] = {
    Model: Model,
    View: View,
    Mediator: Mediator
  };

}).call(this);
