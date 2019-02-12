# frozen_string_literal: true

class CreateTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :tokens do |t|
      t.string :name, default: '', null: false
      t.string :value, default: '', null: false, index: true
      t.datetime :last_used_at
      t.references :created_by, index: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
