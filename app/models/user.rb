class User < ApplicationRecord
  acts_as_paranoid

  devise(
    :invitable, :database_authenticatable, :registerable,
    :rememberable, :trackable, :validatable, :recoverable
  )

  # alias the Devise Invitable method to check if a user is pending creation.
  alias_method(:pending?, :valid_invitation?)

  has_many(:tokens, foreign_key: :created_by_id, dependent: :destroy)
end
