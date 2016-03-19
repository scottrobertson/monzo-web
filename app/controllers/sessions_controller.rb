class SessionsController < ApplicationController

  skip_before_filter :authenticate, only: [:new, :callback]
  skip_before_action :ensure_account, only: [:new, :callback]

  def new
    if cookies.signed[:mondo_token]
      redirect_to accounts_path
    else
      redirect_to MondoService.authorize_url(redirect_uri: callback_sessions_url)
    end
  end

  def callback
    if params[:code]
      token = MondoService.token_from_code(params[:code], redirect_uri: callback_sessions_url)
      cookies.permanent.signed[:mondo_token] = {
       value: token,
       secure: false
      }
    end

    redirect_to accounts_path
  end
end
