Base = CitizenDish.Modules['backbone-base']

Model = Base.Model.extend
  defaults: {}


View = Base.View.extend
#  template: _.template '<input id="fileupload" type="file" name="files[]" data-url="server/node/" multiple>'
  _Model: Model



  after_initialize: (options) ->
#    @$el.append @template()
   $('#media-previews').fileupload
      dataType: 'json'
      done: (evt, data) ->
        console.log 'done', evt, data
      drop: (evt, data) ->
        console.log 'drop', evt, data


CitizenDish.Modules['file-upload'] =
  Model: Model
  View: View

$ () ->
 funcc = () -> new View
 setTimeout funcc, 1000