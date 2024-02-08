# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[7.1] # rubocop:todo Style/Documentation
  def change # rubocop:todo Metrics/MethodLength
    create_table :transactions do |t|
      t.integer :transaction_id
      t.integer :merchant_id
      t.integer :user_id
      t.string :card_number
      t.datetime :transaction_date
      t.float :transaction_amount
      t.integer :device_id
      t.boolean :has_cbk

      t.timestamps
    end

    add_index :transactions, :device_id
    add_index :transactions, :merchant_id
  end
end
