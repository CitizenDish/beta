Base = CitizenDish.Modules['backbone-base']

POCKET_COUNT = 0

Model = Base.Model.extend

  defaults:
    components: [ ]
    style:
      width: 100
      height: 100

View = Base.View.extend
  _Model: Model

  tagName: 'div'
  className: 'design-pocket'

  events:
    'mouseover': () ->
      @timer?.stop()

    'mouseout': () ->
      @timer?.start()

    'drop': (evt) ->
      dragged = window.dragged
      transfer_model = dragged.model.get('item').copy()
      @add_component transfer_model
#      @$el.css resize: 'none'
#      @$el.find('.handle').remove()
#      @$el.draggable 'disable'

      transfer_model.set
        width: @model.get('style')['width']
        height: @model.get('style')['height']

      if transfer_model.get('type') != 'text'
        elements = @$el.find('.design-element')
        _.each elements, (element) ->
          console.log 'setting up el', element
          element.onmousewheel = (evt) ->
            evt.preventDefault()
            console.log 'event wheel', evt
            if evt.ctrlKey
              current_left = transfer_model.get 'left'
              current_top = transfer_model.get 'top'
              transfer_model.set
                left: (current_left + evt.wheelDeltaX)
                top: (current_top + evt.wheelDeltaY)
            else
              width = transfer_model.get 'width'
              height = transfer_model.get 'height'
              delta_resize = evt.wheelDelta / 2
              transfer_model.set
                width: (width + delta_resize)
                height: (height + delta_resize)
            console.log transfer_model.toJSON()


    'dragover': (evt) ->
      evt.preventDefault()

  after_initialize: (options) ->
    components = @model.get 'components'

    @id = "design-pocket-#{++POCKET_COUNT}"
    @$el.attr 'id', @id

  render: () ->
    style = @model.get 'style'

    @$el.css style
#    @$el.append $("<div class='handle'></div>")
    @


  add_component: (component_model) ->
    components = @model.get 'components'
    components.push component_model


#    transfer_view = new CitizenDish.Modules['design-element'].View model: component_model
    transfer_view = CitizenDish.Page['design-element-palette'].model.from_model component_model
    transfer_content = transfer_view.render().$el
    style = @model.get 'style'
    transfer_content.css
      width: style.width
      height: style.height
      left: 0
      top: 0


    @$el.append transfer_content
    if components.length > 1 and not @timer?
        index = 0
        @timer = new CitizenDish.Modules['timer'] () =>
          elements = @$el.find '.design-element'
          show_next_element = () ->
            current_element().hide()
            index = 0 if ++index >= components.length
            current_element().show()
            current_element().transition
              opacity: 1
              scale: 1
              duration: 500
              easing: 'out'
          hide_transition_configuration =
            opacity: 0.3
            scale: 0.4
            duration: 750
            easing: 'in'
            complete: show_next_element
          current_element = () -> $(elements[index])
          current_element().transition hide_transition_configuration
        @timer.interval = 5000
        @timer.start()

class Mediator

  constructor: (@view = new View, @model = new Model) ->
    @view.model = @model

  construct_subjects: () ->
    @view.render()

  set_block: (attribute_block) ->
    style = @model.get 'style'
    extended_style = _.extend {}, style, attribute_block
    @model.set style: extended_style

CitizenDish.Modules['design-pocket'] =
  Model: Model
  View: View
  Mediator: Mediator
