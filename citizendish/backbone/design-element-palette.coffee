Base = CitizenDish.Modules['backbone-base']

IMAGE_COUNT = -1

Model = Base.Model.extend

  rectangle: (model = undefined) ->
    module = CitizenDish.Modules['design-element']
    color = "#" + "#{Math.random()}"[3..8]
    console.log 'color', color
    model ||= new module.Model
      'background-color': color
    view = new module.View model: model

  text: (model = undefined?) ->
    module = CitizenDish.Modules['design-element']
    model ||= new module.Model
      'text': 'sample text'
    view_type = module.View.extend
      tagName: 'p'
    view = new view_type model: model
    view

  image: (model = undefined ) ->
    module = CitizenDish.Modules['design-element']
    model ||= new module.Model
      'image-source': "/images/sample/#{++IMAGE_COUNT}.jpg"
    view_type = module.View.extend
      tagName: 'img'
    view = new view_type model: model
    view

  video: (model = undefined ) ->
    module = CitizenDish.Modules['design-element']
    model ||= new module.Model
      videos: [ ]
    view_type = module.View.extend
      tagName: 'video'
      className: 'sublime design-element'
    view = new view_type model: model

    view.$el.attr
        'poster': 'http://media.sublimevideo.net/vpa/ms_800.jpg'
        'width': 600
        'height': 600
        'data-autoresize': 'none'
        'data-uid': 'a55c1534'
        'data-name': 'Midnight Sun'
        'preload': 'true'
        'data-settings': 'controls-enable: true;fullmode-priority:window'

    view.$el.append ' <source src="http://media.sublimevideo.net/vpa/ms_360p.mp4" />
                    <source src="http://media.sublimevideo.net/vpa/ms_720p.mp4" data-quality="hd" />
                    <source src="http://media.sublimevideo.net/vpa/ms_360p.webm" />
                    <source src="http://media.sublimevideo.net/vpa/ms_720p.webm" data-quality="hd" />'
    view

  from_model: (model) ->
    if model.get('text')?
      @text model
    else if model.get('image-source')?
      @image model
    else if model.get('videos')?
      @video model
    else
      @rectangle model


View = Base.View.extend
  _Model: Model

  tagName: 'aside'

  id: 'design-element-palette'

  after_initialize: (options) ->
    @$el.css @model.toJSON()
    rectangle_template = @model.rectangle()
    text_template = @model.text()
    image_template = @model.image()
    video_template = @model.video()
    sublime?.load()

    @$el.append rectangle_template.render().el
    @$el.append text_template.render().el
    @$el.append image_template.render().el
    @$el.append video_template.render().el

    @$el.hide()
#    @$el.draggable()



CitizenDish.Modules['design-element-palette'] =
  Model: Model
  View: View
