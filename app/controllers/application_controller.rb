class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :authenticate

  def logout!
    cookies.delete :mondo_token
  end

  def mondo
    MondoService.new(cookies.signed[:mondo_token])
  end

  def authenticate
    redirect_to new_session_path unless cookies.signed[:mondo_token]
  end
end
