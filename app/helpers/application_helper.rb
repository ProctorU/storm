# frozen_string_literal: true

module ApplicationHelper
  def body_classes
    user_signed_in? ? 'logged-in' : 'logged-out'
  end

  def body_data_page
    action = case action_name
             when 'create' then 'new'
             when 'update' then 'edit'
             else action_name
             end.downcase

    path = controller.controller_path.split('/')
    namespace = path.first if path.second

    [namespace, controller.controller_name, action].compact.join(':')
  end

  def nav_link(title, link, html_options = {})
    classes = ['nav-item']
    classes << 'active' if current_page?(link)

    content_tag(:li, class: classes) do
      link_to(title, link, html_options.merge(class: 'nav-link'))
    end
  end
end
