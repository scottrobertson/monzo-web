module ApplicationHelper

  def async_partial(url)
    content_tag :div, data: { 'async-partial': url } do
      tag :p, class: 'loader'
    end
  end

end
