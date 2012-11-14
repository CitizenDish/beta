Base = Application.Base

Model = Base.Model.extend
  defaults:
    id: ''
    channel:
      name: ''
    tags: []
    classification_rule: {}
    status: 'untagged'
    interaction:
      author: ''
      source: ''
      date: '00/00/0000'
      title: ''
      link: ''
      content: ''
      type: ''
      sentiment: ''

ChildView = Base.View.extend
    _Model: Model
    id: ''
    template_id: 'post'
    tagName: 'tr'

    on_ready: ->
        @on 'X', @remove
        @on 'junk', @on_junk
        @on 'sentiment', @sentiment_click
        @on 'save', @on_save

    on_junk: ->
        @model.save status: 'junked'
        @remove()

    on_save: ->
        @model.save status: 'verified'
        @remove()

    sentiment_click: (element)->
        @$el.find('a').removeClass('selected')
        interaction = @model.get 'interaction'
        current_sentiment_value = interaction.sentiment
        sentiment_selected_value = element.data('sentiment')
        interaction.sentiment = sentiment_selected_value
        @model.set interaction: interaction
        @$el.find("[data-sentiment=#{sentiment_selected_value}]").addClass("selected")
        @model.save()

    on_render: ->
        summary = @model.get 'interaction'
        sentiment = summary.sentiment
        classifications = @model.get 'classifications'
        # tags = @model.get 'tags'
        @add_sentiment sentiment
        @add_classifications classifications
        # @add_tags tags

    add_sentiment: (sentiment) ->
        sentiment_el = @$el.find '.sentiment_actions'
        sentiment_el.find( "[data-sentiment=#{sentiment}]").addClass 'selected'

    add_classifications: (classifications) ->
        interaction = @model.get 'interaction'
        interaction_title = interaction.title
        classification_el = @$el.find '.classifications'
        classification_view = Application.Classification.from_classifications classifications, interaction_title
        classification_view.render()
        classification_el.html classification_view.el

    add_tags: (tags) ->
        tag_collection_el = @$el.find '.tag_collection'
        option_elements = @generate_option_el_collection tags
        tag_collection_el.html tag_element

    generate_option_el_collection: (collection) ->
        option_el = (value) -> $ "<option>#{value}</option>"
        el_collection = option_el(value) for value in collection
        el_collection

Collection = Base.Collection.extend
    model: Model
    url: '/posts'
    _pre_fetch: true

    filter_condition: 
        'status': 'untagged'

CollectionView = Base.View.extend
    _Collection: Collection
    _ChildView: ChildView
    tagName: 'table'
    template_id: 'post_collection'
    className: 'hidden'

    _collection_parent_element: 'tbody'

    add_paging: -> 
        $('.pager').remove()
        paging_view = new Application.Paging.for_collection @collection
        @$el.after paging_view.el

#        @channel = ChannelSignal.pusher.subscribe 'post_channel'
#        @channel.bind 'data', (data) =>
#            @render_view new Model(data)

    on_render: ->
        @$el.removeClass 'hidden'
        @add_paging()

Application.Post =
    Model: Model
    Collection: Collection
    View: CollectionView