Base = Application.Base

Model = Base.Model.extend {}

View = Base.View.extend
  _Model: Model

Application.Footer =
  Model: Model
  View: View