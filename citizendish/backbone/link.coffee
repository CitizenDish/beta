Base = CitizenDish.Modules['backbone-base']

Model = Base.Model.extend

  defaults:
    'data-attributes':
      'toggle': 'modal'
      'target': '#modal'
      'title': 'tooltip-title'
      'delay': '100'
      'placement': 'right'
    value: 'link'

  initialize: (options = {}) ->
    data_attributes = _.extend({}, @get 'data-attributes')
    data_attributes.target = "##{options.name}-modal"
    data_attributes.title = options['short_description']
    value = options.display || options.name
    @set { value: value, 'data-attributes': data_attributes }

View = Base.View.extend
  _Model: Model

  tagName: 'a'

  events:
    'click': (evt) ->
      CitizenDish.Page['design-canvas'].trigger @model.get('value')
  after_initialize: (options) ->
    @$el.html @model.get 'value'
    _.map @model.get('data-attributes'), (value, key) =>
      @$el.attr "data-#{key}", value


CitizenDish.Modules['link'] =
  Model: Model
  View: View