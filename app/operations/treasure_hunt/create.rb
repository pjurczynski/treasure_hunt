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

    def won?
      distance <= Treasure::WINNING_RADIUS
    end

    def already_won?
      Hunt.where(email: email).winning_locations(treasure_location).exists?
    end
  end

  contract(Contract)

  def process(params)
    @model = Hunt.new

    validate(params, @model) do |form|
      form.distance = form.current_location.distance(form.treasure_location)

      return if form.already_won?

      form.save

      notify_hunter_he_found_treasure!(form.email, form.treasure_location) if form.won?
    end
  end

  def notify_hunter_he_found_treasure!(email, treasure_location)
    found_treasure_count = Hunt.winning_locations(treasure_location).count
    TreasureMailer.found(email, found_treasure_count).deliver_later
  end
end
