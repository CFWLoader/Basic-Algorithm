# @param {String} s
# @return {Boolean}
def is_palindrome(s)

  if s.nil?
    return false
  end

  if s == ''
    return true
  end

  formattedStr = s.downcase

  left = 0; right = formattedStr.size - 1

  while left < right

    if formattedStr[left] < 'a' or formattedStr[left] > 'z'
      left += 1

      next
    end

    if formattedStr[right] < 'a' or formattedStr[right] > 'z'
      right -= 1

      next
    end

    # print "L_index: #{left}, L_value: #{formattedStr[left]}; R_index: #{right}, R_value: #{formattedStr[right]}.\n"

    if formattedStr[left] != formattedStr[right]
      return false
    end

    left += 1

    right -= 1

  end

  true
end

puts is_palindrome 'A man, a plan, a canal: Panama'