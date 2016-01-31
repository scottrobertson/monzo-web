class TransactionsController < ApplicationController
  def index
    @transactions = mondo.transactions(expand: [:merchant], account_id: account_id)
  end

  def show
    @transaction = mondo.transaction(params[:id])
  end
end
