class User < ApplicationRecord
  acts_as_paranoid

  devise(
    :invitable, :database_authenticatable, :registerable,
    :rememberable, :trackable, :validatable
  )

  # alias the Devise Invitable method to check if a user is pending creation.
  alias_method(:pending?, :valid_invitation?)
end
