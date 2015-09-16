class Account < ActiveRecord::Base
  belongs_to :user
  has_many :transactions

  def calculate_interest
    last_transaction = (Date.today - 31.days)
    interest = 0
    current_balance = self.transactions.where("created_at <= ?", last_transaction).sum(:amount)
    relevant_transactions = self.transactions.where("created_at > ?", last_transaction)
    if not relevant_transactions.blank?
      relevant_transactions.each do |transaction|
        balance_days = transaction.created_at.to_date - last_transaction
        if balance_days > 0
          interest += ((current_balance * self.apr)/(365/balance_days))
          last_transaction = transaction.created_at.to_date
        end
        current_balance += transaction.amount
      end
    end
    balance_days = Date.today - last_transaction
    puts "Today: #{Date.today}, Last Transaction: #{last_transaction}, Balance Days: #{balance_days}"
    interest += ((current_balance * self.apr)/(365/balance_days))
    self.transactions.create(transaction_type: 'Interest', amount: interest.ceil) if interest > 0
    self.payment_due = Date.today + 30.days
    self.save
  end
end
