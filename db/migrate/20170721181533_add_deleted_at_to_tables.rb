# frozen_string_literal: true

class AddDeletedAtToTables < ActiveRecord::Migration[5.1]
  def up
    add_column(:users, :deleted_at, :datetime)
    add_index(:users, :deleted_at)

    add_column(:websites, :deleted_at, :datetime)
    add_index(:websites, :deleted_at)

    add_column(:pings, :deleted_at, :datetime)
    add_index(:pings, :deleted_at)
  end

  def down
    remove_column(:users, :deleted_at)
    remove_column(:websites, :deleted_at)
    remove_column(:pings, :deleted_at)
  end
end
