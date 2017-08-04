FactoryGirl.define do
  factory :website do
    sequence(:name) { |n| "Website #{n}" }
    sequence(:url) { |n| "http://#{n}.proctoru.com" }
    ssl(false)
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
