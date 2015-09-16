class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :account, index: true, foreign_key: true
      t.string :transaction_type
      t.decimal :amount, precision:12, scale:2, default: 0.00

      t.timestamps null: false
    end
  end
end
