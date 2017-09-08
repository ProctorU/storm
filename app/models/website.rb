# Website
class Website < ApplicationRecord
  include Paginatable

  VALID_URL_REGEX = /\A#{URI::regexp(['http', 'https'])}\z/

  acts_as_paranoid

  has_many :pings, dependent: :destroy
  has_many :recent_pings, -> { limit(5) }, class_name: 'Ping'
  has_many :daily_pings, -> { limit(1440) }, class_name: 'Ping'

  validates(:name, presence: true)
  validates(:url, presence: true, format: { with: VALID_URL_REGEX })

  before_create(:set_ssl)
  after_commit(:create_ping, on: :create)

  default_scope { active }
  scope(:active, -> { where(active: true) })

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
