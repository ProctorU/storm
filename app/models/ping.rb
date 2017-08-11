class Ping < ApplicationRecord
  acts_as_paranoid

  belongs_to(:website)

  validates(:status, presence: true)
end
