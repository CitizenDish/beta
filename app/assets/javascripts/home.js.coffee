
$(window).resize ->
  body = $ 'body'
  main_element = $ '#main'
  main_element.css
    position: 'absolute'
    left: (body.width() - main_element.outerWidth()) / 2,
    top: (body.height() - main_element.outerHeight()) / 2
