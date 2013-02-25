Base = Application.Base

Model = Base.Model.extend {}

View = Base.View.extend
  _Model: Model

  _template_id: 'editor_console'

Application.EditorConsole =
  Model: Model
  View: View



  # Could nodejs be used in the background to fetch all data, on the client side?