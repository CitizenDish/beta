window.Application = {}

Model = Backbone.Model.extend
  idAttribute: '_id'


View = Backbone.View.extend

  _Model: null
  _Collection: null

  _ChildView: null

  _template_only: false
  _template_id: null

  _draggable: false
  _sortable: false
  _$requires_replace: false

  _collection_parent_element: null

  initialize: ->
    @localize_events()
    @bind_object()
    @inject_event_hooks()
    @setup_view_elements()
    @setup_jquery_ui()
    @initialize_complete()

  localize_events: () ->
    _.bindAll @

  bind_object: () ->
    if @_Model?
      @bind_model @model || new @_Model
    else if @_Collection?
      @bind_collection @collection || new @_Collection

  inject_event_hooks: () ->
    @on 'refresh', @on_display_refresh
    @bound_object.on 'change', @on_change
    @bound_object.on 'reset', @on_reset

  setup_jquery_ui: () ->
    @$el.draggable() if @_draggable
    @$el.sortable() if @_sortable

  setup_view_elements: () ->
    if @_template_id?
      id = @id || @_template_id
      @$el.attr 'id', id
      @_template = Application.HtmlTemplates.find_id @_template_id

  initialize_complete: () -> @

  on_change: () ->
    @trigger 'refresh'

  on_reset: () ->
    @trigger 'refresh'

  on_display_refresh: () ->
    console.log '==='
    console.log @
    console.log 'Refreshed'

  bind_model: (model) ->
    @model = model
    @bound_object = @model

  bind_collection: (collection) ->
    @collection = collection
    @bound_object = @collection

  render: ->
    is_template_only = @_template_only
    if is_template_only
      @render_template()
    else if @model?
      @render_model_view()
    else if @collection?
      @render_collection_view()
    Application.$replace() if @_$requires_replace
    @trigger 'refresh'

  render_template: (data = {} ) ->
    return unless @_template
    template_content = @_template data
    @$el.html template_content

  render_model_view: () ->
    @render_template @model.toJSON()

  render_collection_view: () ->
    @render_template()
    collection_element = @$el
    if @_collection_parent_element?
      collection_element = @$el.find @_collection_parent_element
    collection_element.empty()
    @append_children collection_element

  append_children: (element) ->
    return unless @collection?
    models = @collection.models
    @append_child model, element

  append_child: (model, element) ->
    child_view = new _ChildView model: model
    child_view._parent = @
    element.append child_view.el
    child_view.render()

Collection = Backbone.Collection.extend
  model: Model

  _pre_fetch: false
  _auto_update: false

  _paging:
    size: 50
    page: 1
  _authentication_status: 'unknown'
  _where_filter: {}
  _order: {}
  _last_updated_at: {}

  initialize: () ->
    @localize_events()
    @_refresh() if @_pre_fetch

  localize_events: () ->
    _.bindAll @

  _where: (conditions) ->
    @_where_filter = conditions
    @where conditions          #local filter
    @_refresh()

  _refresh: () ->
    @fetch
      data:
        paging: @_paging
        where: @_where_filter
        order: @_order

  parse: (response) ->
    @_paging = response.paging
    @_authentication_status = response.authentication_status
    @_last_updated_at = Date.now()
    response.results

Router = Backbone.Router.extend

  _history: []

  initialize : () ->
    @localize_events()

  localize_events: () ->
    _.bindAll @

  to : (route) ->
    @_history.push route
    @navigate route, true


window.Application.Base =
  Model: Model
  View: View
  Collection: Collection
  Router: Router

