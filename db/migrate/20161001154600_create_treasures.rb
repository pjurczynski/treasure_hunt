# frozen_string_literal: true

class CreateTreasures < ActiveRecord::Migration[5.0]
  def change
    create_table :treasures do |t|
      t.geometry :location, geographic: true

      t.timestamps
    end

    add_index :treasures, :location, using: :gist
  end
end
