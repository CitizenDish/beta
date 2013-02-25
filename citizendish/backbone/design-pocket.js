(function() {
  var Base, Mediator, Model, POCKET_COUNT, View;

  Base = CitizenDish.Modules['backbone-base'];

  POCKET_COUNT = 0;

  Model = Base.Model.extend({
    defaults: {
      components: [],
      style: {
        width: 100,
        height: 100
      }
    }
  });

  View = Base.View.extend({
    _Model: Model,
    tagName: 'div',
    className: 'design-pocket',
    events: {
      'mouseover': function() {
        var _ref;
        return (_ref = this.timer) != null ? _ref.stop() : void 0;
      },
      'mouseout': function() {
        var _ref;
        return (_ref = this.timer) != null ? _ref.start() : void 0;
      },
      'drop': function(evt) {
        var dragged, elements, transfer_model;
        dragged = window.dragged;
        transfer_model = dragged.model.get('item').copy();
        this.add_component(transfer_model);
        transfer_model.set({
          width: this.model.get('style')['width'],
          height: this.model.get('style')['height']
        });
        if (transfer_model.get('type') !== 'text') {
          elements = this.$el.find('.design-element');
          return _.each(elements, function(element) {
            console.log('setting up el', element);
            return element.onmousewheel = function(evt) {
              var current_left, current_top, delta_resize, height, width;
              evt.preventDefault();
              console.log('event wheel', evt);
              if (evt.ctrlKey) {
                current_left = transfer_model.get('left');
                current_top = transfer_model.get('top');
                transfer_model.set({
                  left: current_left + evt.wheelDeltaX,
                  top: current_top + evt.wheelDeltaY
                });
              } else {
                width = transfer_model.get('width');
                height = transfer_model.get('height');
                delta_resize = evt.wheelDelta / 2;
                transfer_model.set({
                  width: width + delta_resize,
                  height: height + delta_resize
                });
              }
              return console.log(transfer_model.toJSON());
            };
          });
        }
      },
      'dragover': function(evt) {
        return evt.preventDefault();
      }
    },
    after_initialize: function(options) {
      var components;
      components = this.model.get('components');
      this.id = "design-pocket-" + (++POCKET_COUNT);
      return this.$el.attr('id', this.id);
    },
    render: function() {
      var style;
      style = this.model.get('style');
      this.$el.css(style);
      return this;
    },
    add_component: function(component_model) {
      var components, index, style, transfer_content, transfer_view,
        _this = this;
      components = this.model.get('components');
      components.push(component_model);
      transfer_view = CitizenDish.Page['design-element-palette'].model.from_model(component_model);
      transfer_content = transfer_view.render().$el;
      style = this.model.get('style');
      transfer_content.css({
        width: style.width,
        height: style.height,
        left: 0,
        top: 0
      });
      this.$el.append(transfer_content);
      if (components.length > 1 && !(this.timer != null)) {
        index = 0;
        this.timer = new CitizenDish.Modules['timer'](function() {
          var current_element, elements, hide_transition_configuration, show_next_element;
          elements = _this.$el.find('.design-element');
          show_next_element = function() {
            current_element().hide();
            if (++index >= components.length) {
              index = 0;
            }
            current_element().show();
            return current_element().transition({
              opacity: 1,
              scale: 1,
              duration: 500,
              easing: 'out'
            });
          };
          hide_transition_configuration = {
            opacity: 0.3,
            scale: 0.4,
            duration: 750,
            easing: 'in',
            complete: show_next_element
          };
          current_element = function() {
            return $(elements[index]);
          };
          return current_element().transition(hide_transition_configuration);
        });
        this.timer.interval = 5000;
        return this.timer.start();
      }
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

    Mediator.prototype.set_block = function(attribute_block) {
      var extended_style, style;
      style = this.model.get('style');
      extended_style = _.extend({}, style, attribute_block);
      return this.model.set({
        style: extended_style
      });
    };

    return Mediator;

  })();

  CitizenDish.Modules['design-pocket'] = {
    Model: Model,
    View: View,
    Mediator: Mediator
  };

}).call(this);
