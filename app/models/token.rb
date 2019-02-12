# frozen_string_literal: true

# Token
#
# A Token represents the authentication for the API.
class Token < ApplicationRecord
  has_secure_token(:value)

  belongs_to(:created_by, class_name: 'User')

  validates(:created_by_id, presence: true)
  validates(:name, presence: true, uniqueness: { scope: :created_by_id })

  scope(:recent, -> { order(created_at: :desc) })
end
