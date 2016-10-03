# frozen_string_literal: true

module Api::V1
  class AnalyticsController < Api::ApplicationController
    def index
      present ::Analytics::Index

      render json: Api::V1::Analytics::IndexSerializer.new(@model)
    end
  end
end
