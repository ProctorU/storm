class CreateSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :settings do |t|
      t.string :slack_url
      t.string :encrypted_aws_key
      t.string :encrypted_aws_key_iv
      t.string :encrypted_aws_secret
      t.string :encrypted_aws_secret_iv
  
      t.timestamps
    end
  end
end
