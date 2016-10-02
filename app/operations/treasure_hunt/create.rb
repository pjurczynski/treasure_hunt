# frozen_string_literal: true
require 'reform/form/coercion'

class TreasureHunt::Create < ApplicationOperation
  class Contract < Form
    property :current_location, type: CustomTypes::Point
    property :email

    property :treasure_location, type: CustomTypes::Point, virtual: true
    property :distance, type: Types::Form::Int, virtual: true

    validates :email, presence: true
    validates :current_location, presence: true
    validates :treasure_location, presence: true
  end

  contract(Contract)

  def process(params)
    @model = Hunt.new

    validate(params, @model) do |form|
      form.save
      form.distance = form.current_location.distance(form.treasure_location)
    end
  end

  def already_won?
    Hunt.where(email: email).winning_locations(treasure_location).exist?
  end
end
