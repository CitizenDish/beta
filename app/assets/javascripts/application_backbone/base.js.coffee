window.Application = {}

Model = Backbone.Model.extend
  idAttribute: '_id'


View = Backbone.View.extend

  _Model: Model

  initialize: ->
    @localize_events()
    @bind_object()
    @inject_event_hooks()

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


  on_initialize: () -> @

  on_change: () ->
    @trigger 'refresh'

  on_reset: () ->
    @trigger 'refresh'

  on_display_refresh: () -> @

  bind_model: (model) ->
    @model = model
    @bound_object = @model

  bind_collection: (collection) ->
    @collection = collection
    @bound_object = @collection

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
    @_last_updated_at = new Date().now()
    response.results


window.Application.Base =
  Model: Model
  View: View
  Collection: Collection

