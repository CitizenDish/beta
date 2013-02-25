# February-15-2013:5:10 AM
# davidkleriga
# user-media-collection

Base = CitizenDish.Modules['backbone-base']

Model = Base.Model.extend
  defaults: () ->
    items: (new CitizenDish.Modules['user-media-item'].Mediator for [0..11])

View = Base.View.extend
  _Model: Model

  tagName: 'figure'

  className: 'user-media-collection horizontal-scroll'

  after_initialize: (options) ->

class Mediator

  construct_subjects: () ->
    @model = new Model
    @view = new View model: @model
    items = @items()
    horizontal_scroll_wrapper = $("<div class='horizontal-scroll-wrapper'></div>'")
    _.each items, (item) =>
      item.construct_subjects()
      item.view.render()
      horizontal_scroll_wrapper.append item.view.el
    @view.$el.html horizontal_scroll_wrapper
    { view: @view, model: @model }

  items: () ->
    @model.get 'items'

CitizenDish.Modules['user-media-collection'] =
  Model: Model
  View: View
  Mediator: Mediator