class AddGlobalSettings < ActiveRecord::Migration[5.1]
  def up
    SettingsCreator.execute
  end
end
