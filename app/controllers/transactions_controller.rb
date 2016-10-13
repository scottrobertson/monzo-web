class TransactionsController < ApplicationController
  def index
  end

  def list
    @transactions = mondo.transactions(expand: [:merchant], account_id: account_id, since: 7.days.ago.utc.strftime('%FT%TZ'))
    render 'list', layout: false
  end

  def show
    @transaction = mondo.transaction(params[:id])
  end

  def map
    @transactions = mondo
      .transactions(expand: [:merchant], account_id: account_id, since: 30.days.ago.utc.strftime('%FT%TZ'))
      .select { |t| t.merchant && !t.merchant.online?  }
  end
end
