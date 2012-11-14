$ () ->
  $replace()
  $(window).resize()

any_place_holder_elements = () ->
  place_holder_elements().length > 0

place_holder_elements = () ->
  $ '[data-view]'

$replace = () ->
  $load_view element for element in place_holder_elements()
  $replace() if any_place_holder_elements()

$load_view = (place_holder_element) ->
  element = $ place_holder_element
  view_name = element.data 'view'
  view = new Application[view_name].View
  view.render()
  element.replaceWith view.el


Application.$replace = $replace
