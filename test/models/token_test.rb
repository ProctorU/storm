# frozen_string_literal: true

require 'test_helper'

class TokenTest < ActiveSupport::TestCase
  setup do
    @token = build(:token)
  end

  test 'valid' do
    assert(@token.valid?)
  end

  test 'invalid without required attributes' do
    %w(created_by_id name value).each do |attrs|
      @token.send("#{attrs}=", '')
      assert_not(@token.valid?)
    end
  end

  test 'created with value' do
    @token.value = nil
    assert_nil(@token.value)
    @token.save
    assert_not_nil(@token.value)
  end
end
