# frozen_string_literal: true
FactoryGirl.define do
  factory :treasure do
    location "POINT(#{Faker::Address.latitude} #{Faker::Address.longitude})"

    trait :cracow do
      location 'POINT(19.945704 50.051227)'
    end
  end
end
