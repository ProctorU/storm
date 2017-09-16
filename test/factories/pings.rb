FactoryGirl.define do
  factory :ping do
    website { association(:website) }
    response_time { rand(300..1000) }

    trait(:success) do
      status(1)
    end

    trait(:fail) do
      status(0)
    end
  end
end
