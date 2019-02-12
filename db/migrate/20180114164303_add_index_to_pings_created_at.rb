# frozen_string_literal: true

class AddIndexToPingsCreatedAt < ActiveRecord::Migration[5.1]
  def change
    add_index(:pings, :created_at)
  end
end
