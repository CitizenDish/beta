(function() {
  var Base, Model, View;

  Base = CitizenDish.Modules['backbone-base'];

  Model = Base.Model.extend({
    defaults: {
      links: [
        {
          name: 'new',
          short_description: 'New Publication',
          long_description: 'Within this area you can create a new publication'
        }, {
          name: 'upload-media',
          display: '+ media',
          short_description: 'Upload Media',
          long_description: 'Add media from anywhere'
        }, {
          name: 'theme',
          short_description: 'Theme Selector',
          long_description: 'Choose from any of these themes'
        }, {
          name: 'layout',
          short_description: 'Layout Selector',
          long_description: 'Choose from any of these layouts'
        }, {
          name: 'preview',
          short_description: 'Publication Preview',
          long_description: 'This is a preview of your publication'
        }, {
          name: 'save-draft',
          short_description: 'Save Draft',
          long_description: 'Save this design without publishing'
        }, {
          name: 'publish',
          short_description: 'Publish',
          long_description: 'Publish'
        }
      ]
    }
  });

  View = Base.View.extend({
    _Model: Model,
    id: 'sidebar',
    tagName: 'aside',
    after_initialize: function() {
      return this.load_links();
    },
    load_links: function() {
      var link_blocks, link_module,
        _this = this;
      link_module = CitizenDish.Modules['link'];
      link_blocks = this.model.get('links');
      _.each(link_blocks, function(block) {
        var model, view;
        model = new link_module.Model(block);
        view = new link_module.View({
          model: model
        });
        return _this.$el.append(view.render().el);
      });
      return this;
    },
    get_links: function() {
      return this.model.get('links');
    }
  });

  CitizenDish.Modules['sidebar'] = {
    Model: Model,
    View: View
  };

}).call(this);
