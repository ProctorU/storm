class Setting < ApplicationRecord
  attr_encrypted(
    :aws_key,
    key: Rails.application.secrets.secret_key_base.byteslice(0, 32)
  )
  attr_encrypted(
    :aws_secret,
    key: Rails.application.secrets.secret_key_base.byteslice(0, 32)
  )

  before_create :validate_only_one_setting_record

  def self.global
    first
  end

  private

  def validate_only_one_setting_record
    errors.add(:base, 'There can only be one setting') if
      Setting.count.positive?
  end
end
