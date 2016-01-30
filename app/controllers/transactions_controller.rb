class TransactionsController < ApplicationController
  def index
    @transactions = mondo.transactions(expand: [:merchant])
  rescue
    logout!
    redirect_to new_session_path
  end
end
