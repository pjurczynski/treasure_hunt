# frozen_string_literal: true

FactoryGirl.define do
  factory :hunt do
    current_location do
      Utils.point(
        latitude: Faker::Address.latitude,
        longitude: Faker::Address.longitude,
      )
    end
    email Faker::Internet.email

    trait :cracow do
      current_location Utils.point(latitude: 19.945704, longitude: 50.051227)
    end
  end
end
