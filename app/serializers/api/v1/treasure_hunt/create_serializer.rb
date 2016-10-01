# frozen_string_literal: true

module API::V1::TreasureHunt
  class CreateSerializer < ApplicationSerializer
    attributes :status, :distance

    def status
      'ok'
    end

    def distance
      object.contract.distance
    end
  end
end
