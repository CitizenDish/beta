Base = Application.Base

Model = Base.Model.extend {}

View = Base.View.extend
  _Model: Model

  _template_id: 'modal'
  _draggable: true

  _$requires_replace: true

  tagName: 'aside'


Application.Modal =
  Model: Model
  View: View

  load: (resource_type) ->
    resource_model = new resource_type.Model data
    resource_view = new resource_type.View model : resource_model
    resource_view.render()
    Application.Modal.open resource_view.el

  open: (content) ->
    $('#wrapper #modal').remove()
    view = new View
    $('#wrapper').append view.el
    view.render()
    view.$el.find('article').html content




# Collection of modals can be accomplished using jquery tabs for each view