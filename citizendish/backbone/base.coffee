Model = Backbone.Model.extend
  defaults:
    id: 1

  initialize: (options) ->
    _.bindAll @
    @after_initialize options

  after_initialize: (options) -> @

  push_onto: (value, property_name) ->
    property = @get property_name
    property.push value
    @trigger "change:#{property_name}", value

  copy: () ->
    attributes = _.clone @attributes
    new Model attributes

View = Backbone.View.extend
  _Model: Model

  _template_id: undefined

  initialize: (options) ->
    @model = new @__proto__._Model options if not @model?
    _.bindAll @

    @after_initialize options

  after_initialize: () ->  @

  render: () ->
    @template = build_template("##{@_template_id}-template") if @_template_id
    @trigger 'before render'
    if @template?
      template_content = @template @model.toJSON()
      @$el.attr 'id', (@id || @_template_id)
      @$el.html template_content
    @trigger 'after render'
    @


Collection = Backbone.Collection.extend
  model: Model

build_template = (selector) ->
  template_section = $ '#html-templates'
  template_selector = template_section.find(selector)
  _.template template_selector.html() if not template_selector.blank?



CitizenDish.Modules['backbone-base'] =
  Model: Model
  View: View
  Collection: Collection