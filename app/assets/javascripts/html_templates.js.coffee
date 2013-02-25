Application.HtmlTemplates =
  template_section: null
  find_id: (id) =>
    @template_section = $ '#templates'
    selector = "##{id}_template"
    template_element = @template_section.find selector
    template = _.template template_element.html()
