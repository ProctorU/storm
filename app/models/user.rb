class User < ApplicationRecord
  devise(
    :invitable, :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  )
end
