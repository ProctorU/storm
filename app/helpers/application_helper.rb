module ApplicationHelper
  def body_classes
    user_signed_in? ? 'logged-in' : 'logged-out'
  end

  def nav_link(title, link, html_options = {})
    classes = ['nav-item']
    classes << 'active' if current_page?(link)

    content_tag(:li, class: classes) do
      link_to(title, link, html_options.merge(class: 'nav-link'))
    end
  end
end
