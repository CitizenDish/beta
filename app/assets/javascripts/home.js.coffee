
$(window).resize ->
  wrapper = $(window)
  main_element = $ '#page-content'
  wrapper_width = wrapper.outerWidth()
  wrapper_height = wrapper.outerHeight()
  main_element_width = main_element.outerWidth()
  main_element_height = main_element.outerHeight()
  main_element.css
    position: 'absolute'
    left: (wrapper_width - main_element_width) / 2,
    top: (wrapper_height - main_element_height) / 2

Base = Application.Base

Model = Base.Model.extend {}

View = Base.View.extend
  _Model: Model

  tagName: 'section'

  initialize_complete: () ->
    Application.router = new Application.Router
    Backbone.history.start
      pushState: true


Application.Home =
  Model: Model
  View: View
