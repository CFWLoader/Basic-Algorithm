# @param {Integer} num
# @return {String}
def int_to_roman(num)

  # Construct a conversion map.
  # valueMap = {1 => 'I', 5 => 'V', 10 => 'X', 50 => 'L', 100 => 'C', 500 => 'D', 1000 => 'M'}

  bits = Array.new 4

  bits[0] = num % 10
  num /= 10
  bits[1] = num %10
  num /= 10
  bits[2] = num % 10
  num /= 10
  bits[3] = num % 10

  
end