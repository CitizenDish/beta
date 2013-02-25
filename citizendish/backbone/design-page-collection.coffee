# February-15-2013:5:08 AM
# davidkleriga
# design-page-collection

Base = CitizenDish.Modules['backbone-base']

Model = Base.Model.extend
  defaults: () ->
    pages = [ new CitizenDish.Modules['design-page'].Mediator ]
    cover = pages[0]
    active_page = cover
    layout_name = ''
    { pages: pages, cover: cover, active_page: active_page, layout_name: layout_name }

  add_page: (page) ->
    pages = @get 'pages'
    pages.push page
    if pages.length == 1
      @set cover: page, active_instance: page


View = Base.View.extend
  tagName: 'section'

  className: 'design-page-collection'

  render: () ->
    scroll_wrapper = $("<div class='horizontal-scroll-wrapper'></div>'")
    @$el.html scroll_wrapper
    pages = @model.get 'pages'
    console.log 'pages', pages
    _.each pages, (page_mediator) ->
      view = page_mediator.view
      view.render()
      scroll_wrapper.append view.el
    @

class Mediator

  constructor: (@view, @model) ->
    @model = new Model if not @model?
    @view = new View model: @model if not @view?
    CitizenDish.ActiveInstances['design-page-collection'] = @
    @view.model = @model

  construct_subjects: () ->
    @load_layout()
    @view.render( )
    { view: @view, model: @model }

  load_layout: () ->
    layout_name = @model.get 'layout_name'
    layout_manager = CitizenDish.ActiveInstances['layout-manager'] || new CitizenDish.Modules['layout-manager'].Mediator
    result = layout_manager.build_layout layout_name
    console.log 'result', result
    @set_pages result.get_pages()


  get_pages: () ->
    @model.get 'pages'

  set_pages: (page_mediators) ->
    @model.set pages: page_mediators, cover: page_mediators[0]

  page_count: () ->
    @model.get('pages').length

  cover: () ->
    @model.get 'cover'

  create_page: () ->
    @add_new()

  add_new: (page) ->
    if not page?
      page = new CitizenDish.Modules['design-page'].Mediator
    @model.add_page page
    page

  reset_pages: () ->
    @model.set pages: [ ]

  set_cover_to_index: (index = 0) ->
    pages = @get 'pages'
    cover = pages[index]
    @model.set cover: cover

  active_page: () ->
    page = @get_pages()[0]

  preview_on: (design_canvas) ->
    design_canvas.load @active_page()


CitizenDish.Modules['design-page-collection'] =
  Model: Model
  View: View
  Mediator: Mediator