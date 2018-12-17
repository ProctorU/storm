class Ping < ApplicationRecord
  include Paginatable

  attr_accessor(:skip_callbacks)

  belongs_to(:website)

  validates(:status, presence: true)
  validates(:response_time, presence: true)

  default_scope { order(created_at: :desc) }

  after_create(:send_to_ping_notifier, unless: :skip_callbacks)

  def self.without_outliers
    average = average(:response_time).to_f
    max = average * 3

    where.not('response_time > ?', max)
  end

  private

  def send_to_ping_notifier
    Notifiers::PingNotifier.new(self).notify!
  end
end
