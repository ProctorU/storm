require('test_helper')
require('vcr_helper')

module Pings
  # WorkerTest
  class WorkerTest < ActiveSupport::TestCase
    include VcrHelper

    feature 'successful requests' do
      let(:website) do
        VCR.use_cassette('pings/worker/successful/setup') do
          create(:website, url: 'http://httpstat.us/200', ssl: false)
        end
      end

      it 'should return an object with code 200' do
        VCR.use_cassette('pings/worker/successful/default') do
          request = Pings::Worker.new(website).request
          assert_equal('200', request.code)
        end
      end
    end

    feature 'unsuccessful requests' do
      it 'should return an object with code 500' do
        VCR.use_cassette('pings/worker/unsuccessful/default') do
          request = Pings::Worker.new(
            build(:website),
            'http://invalid.proctoru.com'
          ).request
          assert_equal('500', request.code)
        end
      end
    end
  end
end
