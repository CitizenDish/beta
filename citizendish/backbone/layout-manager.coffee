Base = CitizenDish.Modules['backbone-base']

Model = Base.Model.extend
  defaults:  {}

  build_layout: (id = undefined) ->
    return @default_layout() if not id?  or not @[id]?
    return @[id]()

#  black: () ->

  create_page_collection_mediator: () ->
    page_collection_mediator = new CitizenDish.Modules['design-page-collection'].Mediator
    page_collection_mediator.reset_pages()
    page_collection_mediator

  black: () ->
    [ ]

  asphalt: () ->
    page_collection = @create_page_collection_mediator()
    first_page = page_collection.create_page()
    first_page.set_pockets [{ top: 65, left: 0, width: 1024, height: 644 }]
    second_page = page_collection.create_page()
    second_page.set_pockets [ { top: 65, left: 36, width: 351, height: 569 }, { top: 65, left: 413, width: 579, height: 569 }]
    third_page = page_collection.create_page()
    third_page.set_pockets [ { top: 65, left: 36, width: 295, height: 170 }, { top: 65, left: 367, width: 295, height: 170 }
                             { top: 65, left: 698, width: 295, height: 170 }, { top: 278, left: 36, width: 295, height: 170 }
                             { top: 278, left: 367, width: 295, height: 170 },{ top: 278, left: 698, width: 295, height: 170 }
                             { top: 491, left: 36, width: 295, height: 170 }, { top: 491, left: 367, width: 295, height: 170 }
                             { top: 491, left: 698, width: 295, height: 170 }]
    fourth_page = page_collection.create_page()
    fourth_page.set_pockets [
                              {top: 65, left: 36, width: 295, height: 170 }
                              {top: 65, left: 367, width: 295, height: 170 }

                              {top: 278, left: 36, width: 295, height: 170 }

                              {top: 278, left: 367, width: 295, height: 170 }
                              {top: 491, left: 36, width: 295, height: 170 }

                              {top: 491, left: 367, width: 295, height: 170 }

                              {top: 65, left: 698, width: 295, height: 595 }

                            ]
    page_collection

  default_layout: () ->
    page_collection = @create_page_collection_mediator()
    first_page = page_collection.create_page()
    first_page.set_pockets [ { top: 34, left: 0, width: 1024, height: 700 }]

    second_page = page_collection.create_page()
    second_page.set_pockets [ { top: 200, left: 200, width: 500, height: 600 } ]
    third_page = page_collection.create_page()
    third_page.set_pockets [ { top: 30, left: 90, width: 50, height: 660 },{ top: 30, left: 790, width: 150, height: 660 } ]
    page_collection


View = Base.View.extend {}

class Mediator

  constructor: (@view = new View, @model = new Model) ->
    @view.model = @model
    CitizenDish.ActiveInstances['layout-manager'] = @

  build_layout: (id) ->
    @model.build_layout(id || "*")

CitizenDish.Modules['layout-manager'] =
  Model: Model
  View: View
  Mediator: Mediator