# frozen_string_literal: true

require 'test_helper'

class WebsiteDestroyerJobTest < ActiveJob::TestCase
  setup do
    @website = create(:website_with_ping, :success)
  end

  test 'perform' do
    assert_difference('Website.count', -1) do
      assert_difference('Ping.count', -1) do
        WebsiteDestroyerJob.perform_now(@website)
      end
    end
  end
end
