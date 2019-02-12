# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "doe.john@#{n}.com" }
    password { 'password' }
    confirmed_at { Time.zone.now }

    trait(:unconfirmed) do
      confirmed_at { nil }
    end
  end
end
