# frozen_string_literal: true

module APIHelpers
  def json_response(body = response.body, symbolize: false)
    return if body.blank?
    JSON.parse(body, symbolize_keys: symbolize)
  end
end
