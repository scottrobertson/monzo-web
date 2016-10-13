module ApplicationHelper

  def async_partial(url)
    content_tag :div, data: { 'async-partial': url } do
      tag :p, class: 'loader'
    end
  end

  def transaction_logo(transaction)
    transaction.merchant.try(:logo).presence || "http://placehold.it/60x60?text=#{transaction.merchant.try(:name)}"
  end

end
