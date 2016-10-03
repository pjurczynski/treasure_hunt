# frozen_string_literal: true
require 'reform/form/coercion'

class Analytics::Index < ApplicationOperation
  include Collection

  def model!(params)
    relation = Hunt.where(created_at: params[:start_time]..params[:end_time]).limit(10)
    relation = relation.within_range(params[:range], Treasure.current.location) if params[:range]
    relation
  end
end
