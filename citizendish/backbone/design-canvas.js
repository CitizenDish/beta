(function() {
  var Base, Mediator, Model, View, dragged;

  Base = CitizenDish.Modules['backbone-base'];

  dragged = void 0;

  Model = Base.Model.extend({
    defaults: {
      page_index: 0,
      dimensions: {
        width: 1024,
        height: 768
      }
    }
  });

  View = Base.View.extend({
    _Model: Model,
    tagName: 'section',
    id: 'design-canvas'
  });

  Mediator = (function() {

    function Mediator() {}

    Mediator.prototype.page = {};

    Mediator.prototype._property = function(name) {
      return this.model.get(name);
    };

    Mediator.prototype.load = function(design_page) {
      this.page = design_page;
      return this.view.$el.html(this.page.view.el);
    };

    Mediator.prototype.construct_subjects = function(setup_interactions) {
      if (setup_interactions == null) {
        setup_interactions = true;
      }
      CitizenDish.ActiveInstances['design-canvas'] = this;
      this.view = new View;
      this.model = this.view.model;
      if (setup_interactions) {
        this.setup_interactions();
      }
      return {
        view: this.view,
        model: this.model
      };
    };

    Mediator.prototype.setup_interactions = function() {
      this.view.on('new', this.on_view_new, this);
      this.view.on('preview', this.on_view_preview, this);
      this.view.on('before render', this.on_view_before_render, this);
      return this.model.on('change', this.on_model_change, this);
    };

    Mediator.prototype.on_view_new = function() {
      return this.load_new_modal();
    };

    Mediator.prototype.on_view_preview = function() {
      return this.load_preview_modal();
    };

    Mediator.prototype.on_view_before_render = function() {
      return this.load_layout();
    };

    Mediator.prototype.on_model_change = function(evt) {
      return this.update_previews(evt);
    };

    Mediator.prototype.load_new_modal = function() {
      return console.log('new');
    };

    Mediator.prototype.load_preview_modal = function() {
      var current_page, design_pockets, modal_body, page_clone;
      current_page = this.current_page();
      page_clone = $(current_page.clone());
      page_clone.css({
        '-moz-box-shadow': '5px 7px 8px 5px #888',
        '-webkit-box-shadow': '5px 7px 8px 5px #888',
        'box-shadow': '5px 7px 8px 5px #888'
      });
      modal_body = $('#preview-modal .modal-body');
      modal_body.html(page_clone);
      design_pockets = modal_body.find('.design-pocket');
      design_pockets.css({
        'border': 0,
        'padding': 0,
        'resize': 'none'
      });
      modal_body.find('.design-element').attr('contenteditable', 'false');
      modal_body.find('.handle').remove();
      return modal_body.find('.design-pocket.slide').carousel({
        interval: 2000
      });
    };

    Mediator.prototype.update_previews = function(evt) {
      var next_index, previous_index;
      previous_index = evt._previousAttributes.page_index;
      next_index = evt.attributes.page_index;
      this.view.$el.find(".design-page[data-page-index='" + previous_index + "']").hide();
      return this.view.$el.find(".design-page[data-page-index='" + next_index + "']").show();
    };

    Mediator.prototype.load_layout = function(layout_name) {
      if (layout_name == null) {
        layout_name = 'asphalt';
      }
    };

    Mediator.prototype.current_page = function() {
      var index;
      index = this.model.get('page_index');
      return this.view.$el.find(".design-page[data-page-index='" + index + "']");
    };

    return Mediator;

  })();

  CitizenDish.Modules['design-canvas'] = {
    Model: Model,
    View: View,
    Mediator: Mediator
  };

}).call(this);
