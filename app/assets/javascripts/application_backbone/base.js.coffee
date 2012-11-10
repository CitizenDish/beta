
Model = Backbone.Model.extend
  idAttribute: '_id'


View = Backbone.View.extend

  new: (bound_data, type = 'model') ->
    if type == 'model'
      return new ModelView model: bound_data
    else if type == 'collection'
      return new CollectionView collection: bound_data
    else
      return null

  initialize: ->
    @bind_object()
    @localize_events()
    @inject_event_hooks()
    @trigger 'initialize'

  bind_object: () -> @

  localize_events: () ->
    _.bindAll @

  inject_event_hooks: () ->
    @on 'initialize', @on_initialize
    @on 'refresh', @on_display_refresh
    @bound_object.on 'change', @on_change
    @bound_object.on 'reset', @on_reset


  on_initialize: () -> @

  on_change: () ->
    @trigger 'refresh'

  on_reset: () ->
    @trigger 'refresh'

  on_display_refresh: () -> @

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


# Micro View Implementations. Open views and append to instance definition based on model or collection.

ModelView = View.extend
  _view_type: 'model'
  _Model: Model

  bind_object: () ->
    @model = new @_Model unless @model?
    @bound_object = @model


CollectionView = View.extend
  _view_type: 'collection'
  _Collection: Collection

  bind_object: () ->
    @collection = new @_Collection unless @collection?
    @bound_object = @collection

