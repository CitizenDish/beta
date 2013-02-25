# February-15-2013:6:11 AM
# davidkleriga
# user-media-item

MEDIA_ITEM_COUNT = -1

Base = CitizenDish.Modules['backbone-base']

Model = Backbone.Model.extend {}

View = Backbone.View.extend
  _Model: Model

  tagName: 'figure'
  className: 'media-preview img-polaroid'

  events: {
  'mousedown': (evt) ->
    window.dragged = @

  'mouseup': (evt) ->
    window.dragged = undefined
  }

  initialize: (options) ->
    _.bindAll
    @model ||= new Model
    id = ++MEDIA_ITEM_COUNT
    @id = "media-item-preview-#{id}"
    @$el.attr 'id', @id

    @$el.attr 'draggable', true

  render: () ->
    id = @model.get 'id'
    item = {}
    if MEDIA_ITEM_COUNT < 2
      item = CitizenDish.Page['design-element-palette'].model.text()
    else if MEDIA_ITEM_COUNT > 11
      item = CitizenDish.Page['design-element-palette'].model.video()
    else
      item = CitizenDish.Page['design-element-palette'].model.image()
    @model.set item: item.model
    @$el.html item.render().el

class Mediator

  constructor: () ->
    @construct_subjects()

  construct_subjects: () ->
    @model ||= new Model
    @view ||= new View model: @model
    @view.model = @model
    { view: @view, model: @model }


CitizenDish.Modules['user-media-item'] =
  Model: Model
  View: View
  Mediator: Mediator