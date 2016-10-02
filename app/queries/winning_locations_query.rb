# frozen_string_literal: true
class WinningLocationsQuery
  attr_reader :relation, :column, :point

  def initialize(relation:, column:, point:)
    @relation = relation
    @column = String(column)
    @point = point
  end

  def call
    relation.where(round(distance).lteq(Treasure::WINNING_RADIUS))
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
