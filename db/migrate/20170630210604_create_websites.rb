class CreateWebsites < ActiveRecord::Migration[5.1]
  def change
    create_table :websites do |t|
      t.string :name, index: true, unique: true, default: '', null: false
      t.string :url, index: true, unique: true, default: '', null: false
      t.boolean :ssl, default: false
      t.boolean :active, index: true, default: true
      t.string :basic_auth_username
      t.string :basic_auth_password
      t.string :aws_instance_id
      t.string :aws_region
      t.boolean :rebooting, default: false

      t.timestamps
    end
  end
end
