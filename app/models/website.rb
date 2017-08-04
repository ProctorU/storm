class Website < ApplicationRecord
  VALID_URL_REGEX = /\A#{URI::regexp(['http', 'https'])}\z/
  acts_as_paranoid

  has_many :pings, dependent: :destroy

  validates(:name, presence: true)
  validates(:url, presence: true, format: { with: VALID_URL_REGEX })

  default_scope { active }
  scope(:active, -> { where(active: true) })

  def basic_auth?
    [basic_auth_username, basic_auth_password].all?(&:present?)
  end
end
