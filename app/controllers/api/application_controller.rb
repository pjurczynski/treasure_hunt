# frozen_string_literal: true
module API
  class ApplicationController < ActionController::API
    class NotAuthenticated < StandardError; end

    before_action :authenticate_api_token!

    def authenticate_api_token!
      return if request.headers['API_TOKEN'].eql?(Rails.application.secrets.api_token)
      raise NotAuthenticated
    end
  end
end
