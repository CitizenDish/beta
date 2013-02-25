Base = Application.Base

Model = Base.Model.extend {}

View = Base.View.extend
  _Model: Model
  _template_id: 'main_navigation'

  tagName: 'nav'

  initialize_complete: () ->
    console.log 'main navigation initialized'
    router = Application.router
    links = [ 'dashboard', 'editor console', 'tools', 'search' ]
    _.each links, (link) =>
      @on link, () -> router.to link

Application.MainNavigation =
  Model: Model
  View: View