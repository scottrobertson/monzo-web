class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :authenticate
  before_action :ensure_account

  helper_method :balance
  helper_method :account_id
  attr_accessor :account_id

  rescue_from 'Mondo::ApiError' do |exception|
    raise if Rails.env.development?

    logout!
    redirect_to new_session_path
  end

  def ensure_account
    @account_id = params[:account_id]
    redirect_to accounts_path unless @account_id
  end

  def balance
    @_balance ||= mondo.balance(account_id)
  end

  def logout!
    cookies.delete :mondo_token
  end

  def mondo
    MondoService.new(cookies.signed[:mondo_token], account_id)
  end

  def authenticate
    redirect_to new_session_path unless cookies.signed[:mondo_token]
  end
end
