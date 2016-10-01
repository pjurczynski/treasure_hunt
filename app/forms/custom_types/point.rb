# frozen_string_literal: true

require 'reform/form/coercion'

module CustomTypes
  class Point
    def self.call(value)
      return factory.parse_wkt(String(value)) unless value.is_a? Array

      factory.parse_wkt("POINT(#{value.join(' ')})")
    rescue RGeo::Error::ParseError
      value
    end

    def self.factory
      DEFAULT_GEOGRAPHIC_FACTORY
    end
  end
end
