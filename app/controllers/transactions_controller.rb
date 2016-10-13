class TransactionsController < ApplicationController
  def index
  end

  def list
    @transactions = mondo.transactions(expand: [:merchant], account_id: account_id, since: 7.days.ago)
    render 'list', layout: false
  end

  def show
    @transaction = mondo.transaction(params[:id])
  end

  def map
    @transactions = mondo
      .transactions(expand: [:merchant], account_id: account_id, limit: 100)
      .select { |t| t.merchant && !t.merchant.online?  }
  end
end
