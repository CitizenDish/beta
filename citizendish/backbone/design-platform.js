(function() {
  var Base, Model, View;

  Base = CitizenDish.Modules['backbone-base'];

  Model = Base.Model.extend({});

  View = Base.View.extend({
    _Model: Model,
    id: 'design-platform',
    className: 'container',
    after_initialize: function() {
      var design_area, design_element_palette, header, sidebar;
      design_element_palette = new CitizenDish.Modules['design-element-palette'].View;
      CitizenDish.Page['design-element-palette'] = design_element_palette;
      header = new CitizenDish.Modules['header'].View;
      sidebar = new CitizenDish.Modules['sidebar'].View;
      design_area = new CitizenDish.Modules['design-area'].Mediator;
      CitizenDish.Page['header'] = header;
      CitizenDish.Page['sidebar'] = sidebar;
      CitizenDish.Page['design-area'] = design_area;
      design_area.construct_subjects();
      return this.on('after render', function() {
        this.$el.append(header.render().el);
        this.$el.append(design_area.view.render().el);
        this.$el.append(design_element_palette.render().el);
        return this.$el.find('.design-page-collection .design-page:first').click();
      });
    }
  });

  CitizenDish.Modules['design-platform'] = {
    Model: Model,
    View: View
  };

  $(function() {
    var view;
    view = new View({
      el: '.container'
    });
    CitizenDish.Page['design-platform'] = view;
    return view.render();
  });

}).call(this);
