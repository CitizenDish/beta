(function() {
  var Base, IMAGE_COUNT, Model, View;

  Base = CitizenDish.Modules['backbone-base'];

  IMAGE_COUNT = -1;

  Model = Base.Model.extend({
    rectangle: function(model) {
      var color, module, view;
      if (model == null) {
        model = void 0;
      }
      module = CitizenDish.Modules['design-element'];
      color = "#" + ("" + (Math.random())).slice(3, 9);
      console.log('color', color);
      model || (model = new module.Model({
        'background-color': color
      }));
      return view = new module.View({
        model: model
      });
    },
    text: function(model) {
      var module, view, view_type;
      if (model == null) {
        model = void 0 != null;
      }
      module = CitizenDish.Modules['design-element'];
      model || (model = new module.Model({
        'text': 'sample text'
      }));
      view_type = module.View.extend({
        tagName: 'p'
      });
      view = new view_type({
        model: model
      });
      return view;
    },
    image: function(model) {
      var module, view, view_type;
      if (model == null) {
        model = void 0;
      }
      module = CitizenDish.Modules['design-element'];
      model || (model = new module.Model({
        'image-source': "/images/sample/" + (++IMAGE_COUNT) + ".jpg"
      }));
      view_type = module.View.extend({
        tagName: 'img'
      });
      view = new view_type({
        model: model
      });
      return view;
    },
    video: function(model) {
      var module, view, view_type;
      if (model == null) {
        model = void 0;
      }
      module = CitizenDish.Modules['design-element'];
      model || (model = new module.Model({
        videos: []
      }));
      view_type = module.View.extend({
        tagName: 'video',
        className: 'sublime design-element'
      });
      view = new view_type({
        model: model
      });
      view.$el.attr({
        'poster': 'http://media.sublimevideo.net/vpa/ms_800.jpg',
        'width': 600,
        'height': 600,
        'data-autoresize': 'none',
        'data-uid': 'a55c1534',
        'data-name': 'Midnight Sun',
        'preload': 'true',
        'data-settings': 'controls-enable: true;fullmode-priority:window'
      });
      view.$el.append(' <source src="http://media.sublimevideo.net/vpa/ms_360p.mp4" />\
                    <source src="http://media.sublimevideo.net/vpa/ms_720p.mp4" data-quality="hd" />\
                    <source src="http://media.sublimevideo.net/vpa/ms_360p.webm" />\
                    <source src="http://media.sublimevideo.net/vpa/ms_720p.webm" data-quality="hd" />');
      return view;
    },
    from_model: function(model) {
      if (model.get('text') != null) {
        return this.text(model);
      } else if (model.get('image-source') != null) {
        return this.image(model);
      } else if (model.get('videos') != null) {
        return this.video(model);
      } else {
        return this.rectangle(model);
      }
    }
  });

  View = Base.View.extend({
    _Model: Model,
    tagName: 'aside',
    id: 'design-element-palette',
    after_initialize: function(options) {
      var image_template, rectangle_template, text_template, video_template;
      this.$el.css(this.model.toJSON());
      rectangle_template = this.model.rectangle();
      text_template = this.model.text();
      image_template = this.model.image();
      video_template = this.model.video();
      if (typeof sublime !== "undefined" && sublime !== null) {
        sublime.load();
      }
      this.$el.append(rectangle_template.render().el);
      this.$el.append(text_template.render().el);
      this.$el.append(image_template.render().el);
      this.$el.append(video_template.render().el);
      return this.$el.hide();
    }
  });

  CitizenDish.Modules['design-element-palette'] = {
    Model: Model,
    View: View
  };

}).call(this);
