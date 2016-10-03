# frozen_string_literal: true

module Api::V1::TreasureHunt
  class ErrorSerializer < ApplicationSerializer
    attributes :status, :distance, :error

    def status
      'error'
    end

    def distance
      -1
    end

    def error
      object.errors.full_messages.join(', ')
    end
  end
end
