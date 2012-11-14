Base = Application.Base

Model = Base.Model.extend
    defaults: () ->
        date_instance = new Date()
        date_range:
          begin: new Date("#{date_instance.getMonth()+1}-01-#{date_instance.getFullYear()}")
          end: date_instance
        type: '*'
        channel: '*'
        channel_id: '*'
        client: '*'
        title: '*'
        source: '*'
        content: '*'
        status: 'untagged'
        download_results: false

View = Base.View.extend
    _Model: Model
    template_id: 'search'

    sync_model: ->
      checked_val = (checkbox_el) => @$el.find("#{checkbox_el} input").filter(':checked').length > 0
      input_val = (input_el) => @$el.find("#{input_el} input").val()
      option_val = (select_el) =>
        options = @$el.find("select#{select_el} option")
        selected_option = options.filter(':selected').val()
        selected_option
      date_val = (date_el) =>
        today = Date.today()
        selected_value = option_val date_el
        switch selected_value
          when 'current month' then { begin: new Date("#{today.getMonth()+1}-01-#{today.getFullYear()}"), end: today}
          when 'prior month' then { begin: new Date("#{today.getMonth()}-01-#{today.getFullYear()}"), end: new Date("#{today.getMonth()+1}-01-#{today.getFullYear()}")}
          when 'last 30 days' then {begin: (30).days().ago(), end: today }
          when 'last 60 days' then {begin: (60).days().ago(), end: today }
          when 'last 90 days' then {begin: (90).days().ago(), end: today }
      values =
        type: option_val('.types')
        channel: option_val('.channels')
        client: option_val('.clients')
        title: input_val('.title')
        source: input_val('.source')
        content: input_val('.content')
        download_results: checked_val('.download_result')
        date_range: date_val('.dates')
        channel_id: @get_channel_id(option_val('.channels'))
        status: ChannelSignal.EditorConsole.PostStatus
      @model.set values

    get_channel_id: (channel_name) ->
      switch channel_name
        when 'social media' then "50812bcfc3b5a0cd36000003"
        when 'customer reviews' then "50812bbfc3b5a0cd36000001"
        when 'blogs' then "50812bc9c3b5a0cd36000002"
        when 'news' then "50812bd7c3b5a0cd36000004"
        else ''

    on_ready: ->
      @on 'search', @on_search

    generate_query: ->
      query = {}
      set_constraint = (key, property_name) =>
        value = @model.get property_name
        query[key] = value unless value == ''
      set_constraint 'channel_id', 'channel_id'
      set_constraint 'status', 'status'
      set_constraint 'interaction.type', 'type'
      set_constraint 'interaction.title', 'title'
      set_constraint 'interaction.content', 'content'
      set_constraint 'interaction.source', 'source'

      query

    on_search: ->
      @sync_model()

      download_results = @model.get 'download_results'
      date_range = @model.get 'date_range'
      collection = ChannelSignal.PostCollection
      query = @generate_query()
      collection.fetch_query query, date_range
      collection.open_csv() if download_results


Application.Search =
    Model: Model
    View: View