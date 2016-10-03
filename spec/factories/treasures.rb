# frozen_string_literal: true
FactoryGirl.define do
  factory :treasure do
    location do
      Utils.point(
        latitude: Faker::Address.latitude,
        longitude: Faker::Address.longitude,
      )
    end

    trait :cracow do
      location Utils.point(latitude: 19.945704, longitude: 50.051227)
    end
  end
end
