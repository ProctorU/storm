class Ping < ApplicationRecord
  belongs_to(:website)

  validates(:status, presence: true)
end
