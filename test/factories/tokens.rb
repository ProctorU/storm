FactoryBot.define do
  factory :token do
    sequence(:name) { |n| "Token: #{n}" }
    value { SecureRandom.hex }
    association(:created_by, factory: :user)
  end
end
