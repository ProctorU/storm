class Setting < ApplicationRecord
  attr_encrypted(
    :aws_key,
    key: Rails.application.secrets.secret_key_base.byteslice(0, 32)
  )
  attr_encrypted(
    :aws_secret,
    key: Rails.application.secrets.secret_key_base.byteslice(0, 32)
  )

  validate :only_one_setting_record

  private

  def only_one_setting_record
    errors.add(:base, 'There can only be one setting') if Setting.count > 0
  end
end
