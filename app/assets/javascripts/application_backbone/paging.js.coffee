Base = Application.Base

Model = Base.Model

View = Base.View.extend
    Model: Model
    tagName: 'ul'
    className: 'pager'

    setup: ->
        collection = @model.get 'collection'
        paging = collection.paging
        pages = paging.pages
        page = paging.page
        @create_element_index index, page for index in [1..pages]

    create_element_index: (index, page) ->
        css_class = if index == page
            'selected'
        else ''
        list_el = $ "<li><a class='#{css_class}' data-link='page' data-page='#{index}'>#{index}</li>"
        @$el.append list_el


    on_ready: ->
        collection = @model.get 'collection'
        collection.on 'change, reset', @setup
        @setup() if collection.models.length > 0
        @on 'page', @on_page

    on_page: (element) ->
        @$el.find('a').removeClass 'selected'
        page_selected = element.data 'page'
        element.addClass 'selected'
        collection = @model.get 'collection'
        collection.fetch_page page_selected


Application.Paging =
    View: View
    for_collection: (collection) ->
        model = new Model collection: collection
        view = new View model: model
        view