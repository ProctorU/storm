# frozen_string_literal: true

class WebsiteDestroyerJob < ActiveJob::Base
  queue_as(:default)

  def perform(website)
    website.destroy
  end
end
