class Ping < ApplicationRecord
  acts_as_paranoid
  paginates_per(15)

  belongs_to(:website)

  validates(:status, presence: true)

  scope :paginate, (lambda do |params|
    page(params[:page])
  end)
end
