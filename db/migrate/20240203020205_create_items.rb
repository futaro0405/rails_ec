# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :no, null: false
      t.string :name, limit: 30, null: false
      t.integer :price, null: false
      t.text :description

      t.timestamps
      t.index :name, unique: true
    end
  end
end
