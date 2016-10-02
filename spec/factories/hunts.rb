# frozen_string_literal: true

FactoryGirl.define do
  factory :hunt do
    current_location "POINT(#{Faker::Address.latitude} #{Faker::Address.longitude})"
    email Faker::Internet.email

    trait :cracow do
      current_location 'POINT(19.945704 50.051227)'
    end
  end
end
