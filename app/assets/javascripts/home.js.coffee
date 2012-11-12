
$(window).resize ->
  body = $ 'body'
  main_element = $ '#main'

  console.log body.width()
  console.log body.height()
  console.log main_element.outerWidth()
  console.log main_element.outerHeight()

  main_element.css
    position: 'absolute'
    left: (body.width() - main_element.outerWidth()) / 2,
    top: (body.height() - main_element.outerHeight()) / 2
