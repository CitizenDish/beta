(function() {
  var Collection, Model, View, build_template;

  Model = Backbone.Model.extend({
    defaults: {
      id: 1
    },
    initialize: function(options) {
      _.bindAll(this);
      return this.after_initialize(options);
    },
    after_initialize: function(options) {
      return this;
    },
    push_onto: function(value, property_name) {
      var property;
      property = this.get(property_name);
      property.push(value);
      return this.trigger("change:" + property_name, value);
    },
    copy: function() {
      var attributes;
      attributes = _.clone(this.attributes);
      return new Model(attributes);
    }
  });

  View = Backbone.View.extend({
    _Model: Model,
    _template_id: void 0,
    initialize: function(options) {
      if (!(this.model != null)) {
        this.model = new this.__proto__._Model(options);
      }
      _.bindAll(this);
      return this.after_initialize(options);
    },
    after_initialize: function() {
      return this;
    },
    render: function() {
      var template_content;
      if (this._template_id) {
        this.template = build_template("#" + this._template_id + "-template");
      }
      this.trigger('before render');
      if (this.template != null) {
        template_content = this.template(this.model.toJSON());
        this.$el.attr('id', this.id || this._template_id);
        this.$el.html(template_content);
      }
      this.trigger('after render');
      return this;
    }
  });

  Collection = Backbone.Collection.extend({
    model: Model
  });

  build_template = function(selector) {
    var template_section, template_selector;
    template_section = $('#html-templates');
    template_selector = template_section.find(selector);
    if (!(template_selector.blank != null)) {
      return _.template(template_selector.html());
    }
  };

  CitizenDish.Modules['backbone-base'] = {
    Model: Model,
    View: View,
    Collection: Collection
  };

}).call(this);
