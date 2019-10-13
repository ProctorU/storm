# frozen_string_literal: true

class AddEmailAddressToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column(:settings, :email_address, :text)
  end
end
