FactoryBot.define do
  factory :website do
    sequence(:name) { |n| "Website #{n}" }
    sequence(:url) { |n| "http://#{n}.proctoru.com" }
    ssl { false }
    active { true }
    rebooting { false }

    trait(:with_basic_auth) do
      basic_auth_username {'username' }
      basic_auth_password { 'password' }
    end

    trait(:inactive) do
      active { false }
    end

    factory :website_with_ping do
      trait(:success) do
        after(:create) do |website|
          create(:ping, :success, website: website)
        end
      end

      trait(:fail) do
        after(:create) do |website|
          create(:ping, :fail, website: website)
        end
      end
    end
  end
end
