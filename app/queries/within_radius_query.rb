# frozen_string_literal: true
class WithinRadiusQuery
  attr_reader :relation, :column, :point, :radius

  def initialize(relation:, column:, point:, radius:)
    @relation = relation
    @column = String(column)
    @point = point
    @radius = radius
  end

  def call
    relation.where(round(distance).lteq(radius))
  end

  private

  def distance
    Arel::Nodes::NamedFunction.new(
      'ST_Distance',
      [
        arel_column,
        quoted(point.to_s),
      ],
    )
  end

  def round(node)
    Arel::Nodes::NamedFunction.new('round', [node])
  end

  def quoted(value)
    Arel::Nodes::Quoted.new(value)
  end

  def arel_column
    relation.arel_table[column]
  end
end
