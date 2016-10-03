# frozen_string_literal: true
module ApiControllerExampleGroup
  extend ActiveSupport::Concern

  included do
    metadata[:type] = :api_controller

    before do
      request.accept = Mime[:json].to_s
      request.headers['X-API-TOKEN'] = Rails.application.secrets.api_token
    end
  end
end
