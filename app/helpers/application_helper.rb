module ApplicationHelper
  def body_classes
    user_signed_in? ? 'logged-in' : 'logged-out'
  end
end
