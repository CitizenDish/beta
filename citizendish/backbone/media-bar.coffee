Base = CitizenDish.Modules['backbone-base']

Collection = Base.Collection.extend

  initialize: (options) ->
    @__proto__.model = CitizenDish.Modules['media-item'].Model

View = Backbone.View.extend
  _Collection: Collection

  id: 'media-previews'
  tagName: 'section'

  initialize: (options) ->
    models = [ ]
    model_type = CitizenDish.Modules['media-item'].Model
    models.push new model_type(id: index) for index in [1..13]

    horizontal_wrapper = $ "<div class='horizontal-scroll-wrapper'></div>"
    @$el.append horizontal_wrapper
    _.each models, (model) =>
      view = new CitizenDish.Modules['media-item'].View model: model
      horizontal_wrapper.append view.render().el



CitizenDish.Modules['media-bar'] =
  Collection: Collection
  View: View