# frozen_string_literal: true

# WebsiteDecorator
class WebsiteDecorator < Draper::Decorator
  delegate_all
  decorates_association(:pings)
  decorates_association(:recent_pings)
end
