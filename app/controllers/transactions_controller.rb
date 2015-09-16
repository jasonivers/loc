class TransactionsController < ApplicationController
  # GET /transactions/1
  def show
    @transaction = current_user.transactions.find(params[:id])
  end

  # GET /transactions/new
  def new
    @account = current_user.accounts.find_by_id(params[:account_id])
    if not @account.blank?
      @transaction = @account.transactions.new(transaction_type: params[:type].capitalize)
    else
      redirect_to accounts_path, alert: 'Invalid account'
    end
  end

  # POST /transactions
  def create
    @transaction = current_user.transactions.new(transaction_params)
    @transaction.amount = @transaction.amount * -1 if @transaction.transaction_type == 'Payment'
    if(@transaction.account.balance + @transaction.amount > @transaction.account.credit_limit)
      Rails.logger.info "\n\n*****\n#{@transaction.account.balance} - #{amount} - #{@transaction.account.credit_limit}"
      @transaction.errors.add(:amount, "This would exceed your credit limit.")
      @account = @transaction.account
      render :new and return
    end

    if @transaction.save
      redirect_to @transaction.account, notice: 'Transaction was successfully created.'
    else
      render :new
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def transaction_params
      params.require(:transaction).permit(:account_id, :amount, :transaction_type)
    end
end
