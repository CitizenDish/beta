Base = CitizenDish.Modules['backbone-base']

dragged = undefined

Model = Base.Model.extend

  defaults:
    page_index: 0
    dimensions:
      width: 1024
      height: 768

View  = Base.View.extend
  _Model: Model

  tagName: 'section'
  id: 'design-canvas'

class Mediator

  page: {}

  _property: (name) ->
    @model.get name

  load: (design_page) ->
    @page = design_page
#    @page.construct_subjects()
    @view.$el.html @page.view.el

  construct_subjects: (setup_interactions = true) ->
    CitizenDish.ActiveInstances['design-canvas'] = @
    @view = new View
    @model = @view.model
    if setup_interactions
      @setup_interactions()
    { view: @view, model: @model }

  setup_interactions: () ->
    @view.on 'new', @on_view_new, @
    @view.on 'preview', @on_view_preview, @
    @view.on 'before render', @on_view_before_render, @
    @model.on 'change', @on_model_change, @

  on_view_new: () ->
    @load_new_modal()

  on_view_preview: () ->
    @load_preview_modal()

  on_view_before_render: () ->
    @load_layout()

  on_model_change: (evt) ->
    @update_previews evt

  load_new_modal: () ->
    console.log 'new'

  load_preview_modal: () ->
    current_page = @current_page()
    page_clone = $ current_page.clone()
    page_clone.css
      '-moz-box-shadow': '5px 7px 8px 5px #888'
      '-webkit-box-shadow': '5px 7px 8px 5px #888'
      'box-shadow': '5px 7px 8px 5px #888'
    modal_body = $ '#preview-modal .modal-body'
    modal_body.html page_clone
    design_pockets = modal_body.find('.design-pocket')
    design_pockets.css
      'border': 0
      'padding': 0
      'resize': 'none'
    modal_body.find('.design-element').attr 'contenteditable', 'false'
    modal_body.find('.handle').remove()
    modal_body.find('.design-pocket.slide').carousel
      interval: 2000


  update_previews: (evt) ->
    previous_index = evt._previousAttributes.page_index
    next_index = evt.attributes.page_index
    @view.$el.find(".design-page[data-page-index='#{previous_index}']").hide()
    @view.$el.find(".design-page[data-page-index='#{next_index}']").show()

  load_layout: (layout_name = 'asphalt') ->
#    views = CitizenDish.Modules['layout-manager'].build_layout 'asphalt'
#    @view.$el.append view.render().el for view in views


  current_page: () ->
    index = @model.get 'page_index'
    @view.$el.find(".design-page[data-page-index='#{index}']")


CitizenDish.Modules['design-canvas'] =
  Model: Model
  View: View
  Mediator: Mediator
