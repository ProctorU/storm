# Website
class Website < ApplicationRecord
  include Paginatable

  VALID_URL_REGEX = /\A#{URI::regexp(['http', 'https'])}\z/

  has_many :pings, dependent: :delete_all
  has_many :recent_pings, -> { limit(5) }, class_name: 'Ping'
  has_many :daily_pings, -> { limit(1_440) }, class_name: 'Ping'

  # Only query the max number from pagination.
  has_many :paginatable_pings, -> { limit(360) }, class_name: 'Ping'

  validates(:name, presence: true)
  validates(:url, presence: true, format: { with: VALID_URL_REGEX })

  before_create(:set_ssl)
  after_commit(:create_ping, on: :create)

  default_scope { undeleted }
  scope(:active, -> { where(active: true) })
  scope(:undeleted, -> { where(deleted_at: nil) })

  def basic_auth?
    [basic_auth_username, basic_auth_password].all?(&:present?)
  end

  private

  def set_ssl
    self.ssl = URI(url).scheme == 'https'
  rescue
    self.ssl = false
  end

  def create_ping
    PingerJob.perform_later(self)
  end
end
