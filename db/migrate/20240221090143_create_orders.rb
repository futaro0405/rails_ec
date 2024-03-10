# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.string :username, null: false
      t.string :email, null: false
      t.string :address1, null: false
      t.string :address2
      t.string :country, null: false
      t.string :zip, null: false
      t.string :ccname, null: false
      t.integer :ccnumber, null: false
      t.integer :ccexpiration, null: false
      t.integer :cccvv, null: false

      t.timestamps
    end
  end
end
