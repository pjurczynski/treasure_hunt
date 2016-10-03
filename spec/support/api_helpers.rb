# frozen_string_literal: true

module APIHelpers
  def json_response(body = response.body, symbolize: true)
    return if body.blank?
    JSON.parse(body, symbolize_names: symbolize)
  end
end
