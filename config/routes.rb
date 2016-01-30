Rails.application.routes.draw do
  root 'sessions#new'

  resources :transactions, only: [:index]
  resources :sessions, only: [:new] do
    collection do
      get :callback
    end
  end
end
