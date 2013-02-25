Base = CitizenDish.Modules['backbone-base']

Model = Base.Model.extend {}

View = Base.View.extend
  _Model: Model

  id: 'design-platform'
  className: 'container'

  after_initialize: () ->
    design_element_palette = new CitizenDish.Modules['design-element-palette'].View
    CitizenDish.Page['design-element-palette'] = design_element_palette
    header = new CitizenDish.Modules['header'].View
    sidebar = new CitizenDish.Modules['sidebar'].View
    design_area = new CitizenDish.Modules['design-area'].Mediator
    CitizenDish.Page['header'] = header
    CitizenDish.Page['sidebar'] = sidebar
    CitizenDish.Page['design-area'] = design_area
    design_area.construct_subjects()
    @on 'after render', () ->
      @$el.append header.render().el
#      @$el.append sidebar.render().el
      @$el.append design_area.view.render().el
      @$el.append design_element_palette.render().el
#      $('a').tooltip()
      @$el.find('.design-page-collection .design-page:first').click()


CitizenDish.Modules['design-platform'] =
  Model: Model
  View: View




$ () ->
  view = new View el: '.container'
  CitizenDish.Page['design-platform'] = view
  view.render()

