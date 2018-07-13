class RemoveDeletedAtFromTables < ActiveRecord::Migration[5.1]
  def up
    destroy_deleted_users
    destroy_deleted_pings
    destroy_deleted_websites

    remove_column(:users, :deleted_at)
    remove_column(:pings, :deleted_at)
    remove_column(:websites, :deleted_at)
  end

  def down
    add_column(:users, :deleted_at, :datetime)
    add_index(:users, :deleted_at)

    add_column(:websites, :deleted_at, :datetime)
    add_index(:websites, :deleted_at)

    add_column(:pings, :deleted_at, :datetime)
    add_index(:pings, :deleted_at)
  end

  private

  def destroy_deleted_users
    User.where.not(deleted_at: nil).destroy_all
  end

  def destroy_deleted_pings
    Ping.where.not(deleted_at: nil).delete_all
  end

  def destroy_deleted_websites
    Website.where.not(deleted_at: nil).delete_all
  end
end
