Base = CitizenDish.Modules['backbone-base']

LAYOUT_COUNT = 0

Model = Base.Model.extend
  defaults:
    attribute_blocks: [
      { top: 20, left: 20, width: 400, height: 700 }
      { top: 20, left: 520, width: 460, height: 140 }
      { top: 220, left: 520, width: 460, height: 500 }
    ]

# collection of design pockets
View = Base.View.extend
  _Model: Model

  tagName: 'article'
  className: 'design-page'

  after_initialize: (options) ->
    attributes_blocks = @model.get 'attribute_blocks'
    new_design_pocket = () -> $("<div class='design-pocket'></div>").clone()
    _.each attributes_blocks, (block) =>
      pocket = new_design_pocket()
      pocket.css block
      @$el.append pocket
    @$el.attr 'data-page-index', ++LAYOUT_COUNT

CitizenDish.Modules['layout'] =
  Model: Model
  View: View
