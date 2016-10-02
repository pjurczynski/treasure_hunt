# frozen_string_literal: true

class ApplicationOperation < Trailblazer::Operation
  delegate :read_attribute_for_serialization, to: :model
end
