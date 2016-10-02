# frozen_string_literal: true
module Utils
  def self.point(longitude:, latitude:)
    "POINT(#{longitude} #{latitude})"
  end
end
