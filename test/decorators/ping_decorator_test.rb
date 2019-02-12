# frozen_string_literal: true

require 'test_helper'

# PingDecoratorTest
class PingDecoratorTest < Draper::TestCase
  feature 'when the Ping is successful' do
    let(:ping) { build(:ping, :success).decorate }

    feature 'successful?' do
      it 'should return true' do
        assert(ping.successful?)
      end
    end

    feature 'status_badge' do
      it 'should return badge-primary' do
        assert_equal('badge-primary', ping.status_badge)
      end
    end

    feature 'status_text' do
      it 'should return success' do
        assert_equal('success', ping.status_text)
      end
    end
  end

  feature 'when the Ping is unsuccessful' do
    let(:ping) { build(:ping, :fail).decorate }

    feature 'successful? method' do
      it 'should return false' do
        assert_not(ping.successful?)
      end
    end

    feature 'status_badge' do
      it 'should return badge-danger' do
        assert_equal('badge-danger', ping.status_badge)
      end
    end

    feature 'status_text' do
      it 'should return fail' do
        assert_equal('fail', ping.status_text)
      end
    end
  end
end
