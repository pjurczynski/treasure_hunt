# frozen_string_literal: true
class Treasure < ApplicationRecord
  WINNING_RADIUS = 5 # meters

  def self.current
    last || new(location: 'POINT(0 0)')
  end
end
