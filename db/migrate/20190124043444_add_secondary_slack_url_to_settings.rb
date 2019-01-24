class AddSecondarySlackUrlToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :secondary_slack_url, :string
  end
end
