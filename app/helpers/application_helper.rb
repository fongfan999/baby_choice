module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "Lựa chọn tốt cho bé - Trang review các sản phẩm cho mẹ và bé hàng đầu Việt Nam").join(" - ")
      end
    end
  end

  def highlight_title(title, query)
    if query.present?
      highlight(title, query.split)
    else
      title    
    end
  end
end
