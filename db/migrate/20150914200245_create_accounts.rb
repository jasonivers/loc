class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :user, index: true, foreign_key: true
      t.decimal :balance, precision:12, scale:2, default: 0.00
      t.decimal :credit_limit, precision:12, scale:2, default: 1000.00
      t.decimal :apr, precision:6, scale:3, default: 0.35
      t.datetime :payment_due, default: (Date.today + 30.days)

      t.timestamps null: false
    end
  end
end
