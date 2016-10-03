# frozen_string_literal: true
class Hunt < ApplicationRecord
  scope :winning_locations, (lambda do |location|
    WithinRadiusQuery.new(
      relation: self,
      column: :current_location,
      point: String(location),
      radius: Treasure::WINNING_RADIUS,
    ).call
  end)
end
