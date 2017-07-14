require 'test_helper'

class WebsiteTest < ActiveSupport::TestCase
  setup do
    @website = build(:website)
  end

  test 'valid' do
    assert(@website.valid?)
  end

  test 'invalid without required attributes' do
    %w(name url).each do |attrs|
      @website.send("#{attrs}=", '')
      assert_not(@website.valid?)
    end
  end

  test 'invalid without a valid URL' do
    %w(invalid@ @invalid.com).each do |invalid_url|
      @website.url = invalid_url
      assert_not(@website.valid?)
    end
  end

  test 'active scope' do
    assert_includes(Website.active, create(:website))
    assert_not_includes(Website.active, create(:website, :inactive))
  end
end
