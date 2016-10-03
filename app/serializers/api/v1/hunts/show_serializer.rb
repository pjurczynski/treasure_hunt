# frozen_string_literal: true
module Api::V1::Hunts
  class ShowSerializer < ApplicationSerializer
    attributes :email, :current_location

    def current_location
      object.current_location.coordinates
    end
  end
end
