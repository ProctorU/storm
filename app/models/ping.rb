class Ping < ApplicationRecord
  include Paginatable
  acts_as_paranoid

  belongs_to(:website)

  validates(:status, presence: true)
  validates(:response_time, presence: true)
end
