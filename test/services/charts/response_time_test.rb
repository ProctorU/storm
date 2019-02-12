# frozen_string_literal: true

require('test_helper')

module Charts
  # ResponseTimeTest
  class ResponseTimeTest < ActiveSupport::TestCase
    setup do
      website = create(:website)
      10.times { create(:ping, :success, website: website) }
      @pings = website.pings
    end

    test 'aggregate returns 60 hashes' do
      aggregation = Charts::ResponseTime.new(@pings).aggregate
      assert_equal(60, aggregation.length)
    end

    test 'aggregate returns times from 0 to 1180' do
      aggregation = Charts::ResponseTime.new(@pings).aggregate
      assert_equal(steps, aggregation.map { |a| a[:time] }.sort)
    end

    private

    def steps
      [
        0, 20, 40, 60, 80, 100, 120, 140, 160, 180, 200, 220, 240,
        260, 280, 300, 320, 340, 360, 380, 400, 420, 440, 460, 480,
        500, 520, 540, 560, 580, 600, 620, 640, 660, 680, 700, 720,
        740, 760, 780, 800, 820, 840, 860, 880, 900, 920, 940, 960,
        980, 1000, 1020, 1040, 1060, 1080, 1100, 1120, 1140, 1160,
        1180
      ]
    end
  end
end
