require('test_helper')
require('vcr_helper')

module Pings
  # ManagerTest
  class ManagerTest < ActiveSupport::TestCase
    include VcrHelper
    include ActiveJob::TestHelper

    feature 'successful websites' do
      let(:website) do
        VCR.use_cassette('pings/successful/setup') do
          perform_enqueued_jobs do
            create(:website, url: 'http://httpstat.us/200', ssl: false)
          end
        end
      end

      it 'should create a ping' do
        VCR.use_cassette('pings/successful/default') do
          assert_difference -> { website.pings.size } do
            Pings::Manager.new(website).ping
          end
        end
      end

      it 'should create a ping with correct status' do
        VCR.use_cassette('pings/successful/status') do
          ping = Pings::Manager.new(website).ping
          assert(ping.status.eql?(1))
        end
      end
    end

    feature 'unsuccessful websites' do
      let(:website) do
        VCR.use_cassette('pings/unsuccessful/setup') do
          perform_enqueued_jobs do
            create(:website, url: 'http://httpstat.us/500', ssl: false)
          end
        end
      end

      it 'should enqueue another job if first retry' do
        VCR.use_cassette('pings/unsuccessful/retry/one') do
          assert_enqueued_jobs(1) do
            Pings::Manager.new(website).ping
          end
        end
      end

      it 'should enqueue another job if second retry' do
        VCR.use_cassette('pings/unsuccessful/retry/two') do
          assert_enqueued_jobs(1) do
            website.pings.last.update_column(:retry_count, 2)
            Pings::Manager.new(website, true).ping
          end
        end
      end

      it 'should not enqueue another job if third retry' do
        assert_enqueued_jobs(0) do
          website.pings.last.update_column(:retry_count, 3)
          Pings::Manager.new(website, true).ping
        end
      end
    end
  end
end
