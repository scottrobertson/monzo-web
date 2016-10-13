class AccountsController < ApplicationController

  skip_before_action :ensure_account

  def index
    @accounts = mondo.accounts
    if @accounts.count == 1
      return redirect_to account_transactions_path(@accounts.first.id)
    end
  end
end
