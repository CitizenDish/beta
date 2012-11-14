Base = Application.Base

Router = Base.Router.extend
  routes :
    'dashboard' :      'dashboard'
    'editor_console' : 'editor_console'
    'search' :         'search'
    'tools' :          'tools'
    'login':  'login'
    'logout' :         'logout'
    '' :               'editor_console'

  modal : (resource_type, data = {}) ->
    Application.Modal.load resource_type, data

  body_view : (view_type) ->
    console.log view_type
    view = new Application[view_type].View
    if $("#content ##{view.id}").length == 0
      view.render()
      content_wrapper = $ '#content'
      content_wrapper.html view.el

  dashboard : -> @body_view 'Dashboard'
  editor_console : -> @body_view 'EditorConsole'
  search : ->
    @modal Application.Search
    @to 'editor_console'
  tools : -> @modal Application.Tools
  login: -> console.log 'login'
  logout : -> console.log 'logout'


Application.Router = Router