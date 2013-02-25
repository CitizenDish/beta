Base = CitizenDish.Modules['backbone-base']

Model = Base.Model.extend
  defaults:
    elements: [ ]
    current_element: undefined

  after_initialize: (options) ->
    @timer = new CitizenDish.Modules['timer'] @on_timer_expire, @
    @timer.interval = 3000
    @timer.start()
    @on 'change:elements', (value) ->
      @set current_element: value

  begin_timer: () ->
    @timer.start()

  on_timer_expire: () ->
    console.log 'timer went off', @

  stop_timer: () ->
    @timer.stop()


View = Base.View.extend
  _Model: Model

  children_views: [ ]

  tagName: 'figure'

  after_initialize: (options) ->
    @model.on 'change:current_element', (evt) ->
      console.log 'current element changed', evt, @
      previous_value = evt.previous
      current_value = evt.changed
      @children_views[previous_value].hide()
      @children_views[value].show()


CitizenDish.Modules['design-slideshow'] =
  Model: Model
  View: View