class CreatePings < ActiveRecord::Migration[5.1]
  def change
    create_table :pings do |t|
      t.belongs_to :website, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
