FactoryGirl.define do
  factory :website do
    sequence(:name) { |n| "Website #{n}" }
    sequence(:url) { |n| "https://#{n}.proctoru.com" }
    ssl(true)
    active(true)

    trait(:with_basic_auth) do
      basic_auth_username('username')
      basic_auth_password('password')
    end

    trait(:inactive) do
      active(false)
    end
  end
end
