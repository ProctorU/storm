# frozen_string_literal: true

require 'test_helper'

class PingTest < ActiveSupport::TestCase
  setup do
    @ping = build(:ping, :success)
  end

  test 'valid' do
    assert(@ping.valid?)
  end

  test 'invalid without required attributes' do
    %w(status response_time).each do |attrs|
      @ping.send("#{attrs}=", nil)
      assert_not(@ping.valid?)
    end
  end
end
