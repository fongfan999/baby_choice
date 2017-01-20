module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "Lựa chọn tốt cho bé - Trang review các sản phẩm cho mẹ và bé lớn nhất Việt Nam").join(" - ")
      end
    end
  end

  def hi
    "Hello World"
  end
end
