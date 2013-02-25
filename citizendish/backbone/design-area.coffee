Base = CitizenDish.Modules['backbone-base']

Model = Base.Model.extend {}

View = Base.View.extend
  _Model: Model

  tagName: 'section'
  id: 'design-area'

  load: (views) ->
    @$el.append view.render().el for view in views

  after_initialize: (options) ->
#    @$el.append thumbnail_bar.render().el
#    @$el.append $('<hr />')


class Mediator

  construct_subjects: () ->
    @view = new View
    @model = @view.model
    @design_canvas = new CitizenDish.Modules['design-canvas'].Mediator
    @design_page_collection = new CitizenDish.Modules['design-page-collection'].Mediator
    @user_media_previews = new CitizenDish.Modules['user-media-collection'].Mediator
    mediator.construct_subjects() for mediator in [ @design_canvas, @design_page_collection, @user_media_previews ]
    @view.load [ @design_page_collection.view, @user_media_previews.view, @design_canvas.view]
    @design_page_collection.preview_on @design_canvas

    {
      model: @model                                                   # Tis just a vessel for you man. The real magic is thyself. ( Make it so! )
      view: @view
    }


  get_components: () ->
    'design-page-collection': @design_page_collection
    'user-media-collection': @user_media_previews
    'design-canvas': @design_canvas


CitizenDish.Modules['design-area'] =
  Model: Model
  View: View
  Mediator: Mediator