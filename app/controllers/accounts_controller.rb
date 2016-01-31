class AccountsController < ApplicationController

  skip_before_action :ensure_account

  def index
    @accounts = mondo.accounts
  end
end
