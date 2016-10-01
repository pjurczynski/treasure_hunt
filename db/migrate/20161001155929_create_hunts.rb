# frozen_string_literal: true
class CreateHunts < ActiveRecord::Migration[5.0]
  def change
    create_table :hunts do |t|
      t.string :email
      t.geometry :current_location, geographic: true

      t.timestamps
    end

    add_index :hunts, :current_location, using: :gist
    add_index :hunts, :email
  end
end
