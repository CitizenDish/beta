Model = Backbone.Model.extend {}

View = Backbone.View.extend
  _Model: Model

  tagName: 'article'
  className: 'page-preview img-polaroid'

  events: {
    'click': () ->
      design_canvas = CitizenDish.Page['design-canvas-mediator']
      design_canvas.model.set page_index: @model.get('id')
      page_copy = $(design_canvas.current_page().clone())
      page_copy.id = ''
      page_copy.css { width: 0, height: 0, overflow: 'visible' }
      @$el.html page_copy
  }

  initialize: (options) ->
    @model ||= new @__proto__._Model
    id = @model.get 'id'
    @id = "page-preview-#{id}"
    @$el.attr 'id', @id
    @$el.attr 'data-preview-page-index', id

CitizenDish.Modules['page-preview'] =
  Model: Model
  View: View