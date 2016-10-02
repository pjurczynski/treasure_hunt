# frozen_string_literal: true

module API::V1
  class TreasureHuntsController < API::ApplicationController
    def create
      run ::TreasureHunt::Create, params: treasure_hunt_params

      if @operation.valid?
        render json: @operation,
               status: :created,
               serializer: API::V1::TreasureHunt::CreateSerializer
      else
        render json: @operation,
               status: :unprocessable_entity,
               serializer: API::V1::TreasureHunt::ErrorSerializer
      end
    end

    private

    def treasure_hunt_params
      params.merge(treasure_location: Treasure.first.try(:location))
    end
  end
end
