# frozen_string_literal: true
module ApiControllerExampleGroup
  extend ActiveSupport::Concern

  included do
    metadata[:type] = :api_controller

    before { request.accept = Mime::JSON.to_s }
  end
end
