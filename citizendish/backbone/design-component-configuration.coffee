# February-09-2013:5:43 PM
# davidkleriga


Base = CitizenDish.Modules['backbone-base']

Model = Base.Model.extend
  defaults:
    {}

View = Base.View.extend
  _Model: Model

  after_initialize: (options) ->

CitizenDish.Modules['design-component-configuration'] =
  Model: Model
  View: View