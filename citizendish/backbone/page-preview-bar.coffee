Base = CitizenDish.Modules['backbone-base']

Collection = Base.Collection.extend
  model: CitizenDish.Modules['page-preview']

View = Backbone.View.extend

  _Collection: Collection

  id: 'page-previews'
  tagName: 'section'

  initialize: (options) ->
#    if not @collection?
#      @collection = new @__proto__._Collection
    models = [ ]
    model_type = CitizenDish.Modules['page-preview'].Model
    models.push new model_type(id: 1)
    models.push new model_type(id: 2)
    models.push new model_type(id: 3)
    models.push new model_type(id: 4)
#    @collection.add models
    horizontal_wrapper = $ "<div class='horizontal-scroll-wrapper'></div>"
    @$el.append horizontal_wrapper
    console.log 'page preview bar', @collection
    _.each models, (model) =>
      view = new CitizenDish.Modules['page-preview'].View model: model
      horizontal_wrapper.append view.render().el


CitizenDish.Modules['page-preview-bar'] =
  Collection: Collection
  View: View