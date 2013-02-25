Base = CitizenDish.Modules['backbone-base']

Model = Base.Model.extend
  defaults:
    title: 'CitizenDish'
    name: 'new'


View = Base.View.extend
  _Model: Model

  _template_id: 'modal'

  tagName: 'article'
  className: 'modal hide fade'

  after_initialize: (options) ->
    name = @model.get 'name'
    @id = "#{name}-modal"

CitizenDish.Modules['modal'] =
  Model: Model
  View: View


#$ () ->
#  modal_area = $ '#modals'
#  sidebar_links = CitizenDish.Page['sidebar'].get_links()
#  _each = (attributes) ->
#    model = new Model attributes
#    view = new View model: model
#  views = (_each(block) for block in sidebar_links)
#  modal_area.append view.render().el for view in views