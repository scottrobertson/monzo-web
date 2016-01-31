class SessionsController < ApplicationController

  skip_before_filter :authenticate, only: [:new, :callback]
  skip_before_action :ensure_account, only: [:new, :callback]

  def new
    redirect_to MondoService.authorize_url(redirect_uri: callback_sessions_url)
  end

  def callback
    if params[:code]
      token = MondoService.token_from_code(params[:code], redirect_uri: callback_sessions_url)
      cookies.permanent.signed[:mondo_token] = {
       value: token,
       secure: !Rails.env.development?
      }
    end


    redirect_to accounts_path
  end
end
