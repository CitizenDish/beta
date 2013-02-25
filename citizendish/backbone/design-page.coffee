Base = CitizenDish.Modules['backbone-base']

PAGE_COUNT = 0

Model = Base.Model.extend

  defaults:
    pockets: [ ]
    style:
#      'background-color': 'transparent'
      border: 0

View = Base.View.extend
  _Model: Model

  tagName: 'article'
  className: 'design-page img-polaroid'

  events:
    'click': () ->
      console.log 'click', @

  initialize: (options) ->
    _.bindAll @

  render: () ->
    @$el.html ""
    @render_pockets()
    @$el.attr 'data-page-index', ++PAGE_COUNT
    @$el.css @model.get('style')
    @

  render_pockets: () ->
    pockets = @model.get 'pockets'
    console.log 'pockets', pockets
    _.each pockets, (pocket) =>
      view = pocket.view
      @$el.append view.render().el

class Mediator

  constructor: (@view = new View, @model = new Model) ->
    @view.model = @model

  construct_subjects: () ->
    @view.render()

  set_pockets: (pocket_collection) ->
    pockets = [ ]
    _.each pocket_collection, (pocket_block) ->
      pocket = new CitizenDish.Modules['design-pocket'].Mediator
      pocket.set_block pocket_block
      pockets.push pocket
    @model.set pockets: pockets
    @view.render()

  get_pockets: () ->
    @model.get 'pockets'

CitizenDish.Modules['design-page'] =
  Model: Model
  View: View
  Mediator: Mediator