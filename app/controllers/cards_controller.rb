class CardsController < ApplicationController
  def index
    @cards = mondo.cards(account_id: account_id)
  end

  def freeze
    @card = mondo.cards(account_id: account_id).select { |c| c.id == params[:card_id] }.first
    @card.freeze!
    redirect_to :back
  end

  def unfreeze
    @card = mondo.cards(account_id: account_id).select { |c| c.id == params[:card_id] }.first
    @card.unfreeze!
    redirect_to :back
  end
end
