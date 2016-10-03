# frozen_string_literal: true

module Api::V1::Analytics
  class IndexSerializer < ApplicationSerializer
    attributes :status, :requests

    def status
      'ok'
    end

    def requests
      ActiveModel::Serializer::CollectionSerializer.new(
        object.object,
        serializer: Api::V1::Hunts::ShowSerializer,
      )
    end
  end
end
