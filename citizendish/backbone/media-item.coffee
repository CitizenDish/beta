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
    @model ||= new @__proto__._Model
    id = ++MEDIA_ITEM_COUNT
    @id = "media-item-preview-#{id}"
    @$el.attr 'id', @id

    @$el.attr 'draggable', true

    @on 'before render', () ->
      item = {}
      if id < 2
        item = CitizenDish.Page['design-element-palette'].model.text()
      else if id > 11
        item = CitizenDish.Page['design-element-palette'].model.video()
      else
        item = CitizenDish.Page['design-element-palette'].model.image()
      @model.set item: item.model
      @$el.html item.render().el


CitizenDish.Modules['media-item'] =
  Model: Model
  View: View