Base = Application.Base

Model = Base.Model.extend 
    defaults: () ->
        classifications: [
            { tags: [], terms: [], category: '' }
        ]
        terms: ""

View = Base.View.extend 
    _Model: Model
    tagName: 'section'

    on_ready: ->
        @on 'new rule', @new_rule
        classifications = @model.get 'classifications'
        if classifications.length > 0
            tags = (@format_tags classification for classification in classifications)
            select_el = $ "<select></select>"
            option_el_collection = @generate_option_el_collection tags
            select_el.html option_el_collection
            @$el.html select_el
        else 
            new_rule_el = $ "<a data-link='new rule'>Set Rule Match</a>"
            @$el.html new_rule_el

    format_tags: (classification) ->
        classification.tags.join ':'

    new_rule: ->
        terms = @model.get 'terms'
        model = new ChannelSignal.NewClassificationRule.Model terms: terms
        view = new ChannelSignal.NewClassificationRule.View model: model
        view.render()
        ChannelSignal.Modal.open view.el

    generate_option_el_collection: (collection) ->
        option_el = (value) -> $ "<option>#{value}</option>"
        el_collection = option_el(value) for value in collection
        el_collection

Application.Classification =
    Model: Model
    View: View
    from_classifications: (classifications, interaction_title) ->
        model = new Model classifications: classifications, terms: interaction_title
        view = new View model: model