Application.HtmlTemplates =
  template_section_id: '#templates'
  template_section: null
  find_id: (id) =>
    @template_section = $ @template_section_id
    selector = "##{id}_template"
    template = @template_section.find selector
