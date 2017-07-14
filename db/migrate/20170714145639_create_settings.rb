class CreateSettings < ActiveRecord::Migration[5.1]
  def up
    create_table :settings do |t|
      t.string :slack_url
      t.string :encrypted_aws_key
      t.string :encrypted_aws_key_iv
      t.string :encrypted_aws_secret
      t.string :encrypted_aws_secret_iv

      t.timestamps
    end
  end

  def down
    drop_table(:settings)
  end
end
