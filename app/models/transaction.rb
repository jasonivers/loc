class Transaction < ActiveRecord::Base
  belongs_to :account
  after_save :update_account_balance
  after_destroy :update_account_balance

  private
  def update_account_balance
    self.account.update(balance: self.account.transactions.sum(:amount))
  end
end
