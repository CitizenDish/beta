
$(window).resize ->
  body = $ 'body'
  main_element = $ '#main'
  main_element.css
    position: 'absolute'
    left: (body.width() - main_element.outerWidth()) / 2,
    top: (body.height() - main_element.outerHeight()) / 2

Base = Application.Base

Model = Base.Model.extend {}

View = Base.View.extend
  className: 'active_view'


Application.Home =
  Model: Model
  View: View
