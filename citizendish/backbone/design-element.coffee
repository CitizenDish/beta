Base = CitizenDish.Modules['backbone-base']

Model = Base.Model.extend
  defaults:
    'background-color': 'transparent'
    'width': '100%'
    'height': '100%'
    'left': 0
    'top': 0


  after_initialize: (options = {}) ->
    if options['image-source']?
      @set type: 'image'
    else if options['text']?
      @set type: 'text'
    else
      @set type: 'rectangle'

View = Base.View.extend
  _Model: Model

  className: 'design-element item'
  tagName: 'figure'


  after_initialize: (options) ->
    @$el.css @model.toJSON()

    if @model.get('type') == 'image'
      image_source = @model.get 'image-source'
      @$el.attr 'src', image_source
    else if @model.get('type') == 'text'
      @$el.html @model.get('text')
      @$el.attr 'contenteditable', true
    @$el.attr 'draggable', false

    @model.on 'change', (evt) =>
      @$el.css @model.toJSON()




CitizenDish.Modules['design-element'] =
  Model: Model
  View: View
