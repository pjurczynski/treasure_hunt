# frozen_string_literal: true
class Hunt < ApplicationRecord
  scope :winning_locations, (lambda do |location|
    WinningLocationsQuery.new(
      relation: self,
      column: :current_location,
      point: String(location),
    ).call
  end)
end
