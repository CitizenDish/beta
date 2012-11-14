Base = Application.Base

Model = Base.Model.extend {}

View = Base.View.extend
  _Model: Model

Application.EditorConsole =
  Model: Model
  View: View