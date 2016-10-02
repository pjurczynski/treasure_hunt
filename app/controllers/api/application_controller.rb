# frozen_string_literal: true
module API
  class ApplicationController < ActionController::API
    class NotAuthenticated < StandardError; end
    class TooManyRequestsPerHour < StandardError; end

    before_action :authenticate_api_token!
    before_action :check_throttle!

    def authenticate_api_token!
      return if request.headers['API_TOKEN'].eql?(Rails.application.secrets.api_token)
      raise NotAuthenticated
    end

    def check_throttle!
      return if params[:email].nil?

      throttler = Throttler.new(params[:email])
      raise TooManyRequestsPerHour if throttler.max_reached?

      throttler.requested!
      nil
    end
  end
end
