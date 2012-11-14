module ApplicationHelper

  def backbone_view name, options = {}
    options[:class] ||= 'backbone_view'
    html_element = options[:element] || 'div'
    options['data-view'] = name
    generate_view html_element, options
  end


  def generate_view(element = "div", options)
    content_tag(element, nil, options)
  end
end
