# frozen_string_literal: true

class AddPostgisExtension < ActiveRecord::Migration[5.0]
  def change
    enable_extension :postgis
  end
end
