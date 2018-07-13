class Ping < ApplicationRecord
  include Paginatable
  acts_as_paranoid

  attr_accessor(:skip_callbacks)

  belongs_to(:website)

  validates(:status, presence: true)
  validates(:response_time, presence: true)

  default_scope { order(created_at: :desc) }

  after_create(:send_to_ping_notifier, unless: :skip_callbacks)

  private

  def send_to_ping_notifier
    Notifiers::PingNotifier.new(self).notify!
  end
end
