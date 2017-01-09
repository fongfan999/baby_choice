class String
  def delete_tonal
    return if self.blank?

    vietnamese_dic = {
      'a': 'áàảãạăắặằẳẵâấầẩẫậÁÀẢÃẠĂẮẶẰẲẴÂẤẦẨẪẬ',
      'd': 'đĐ',
      'e': 'éèẻẽẹêếềểễệÉÈẺẼẸÊẾỀỂỄỆ',
      'i': 'íìỉĩịÍÌỈĨỊ',
      'o': 'óòỏõọôốồổỗộơớờởỡợÓÒỎÕỌÔỐỒỔỖỘƠỚỜỞỠỢ',
      'u': 'úùủũụưứừửữựÚÙỦŨỤƯỨỪỬỮỰ',
      'y': 'ýỳỷỹỵÝỲỶỸỴ',
    }

    # Capture self
    str = self.dup

    # Get all characters as array
    chars_array = str.split("").delete_if(&:blank?)

    # Check each char and replace it if it's tonal
    chars_array.each do |char|
      vietnamese_dic.each do |vowel, list_tonal|
        if list_tonal.split("").include?(char)
          str.sub!(char, vowel.to_s)
          break
        end
      end
    end

    # return to self
    str
  end
end