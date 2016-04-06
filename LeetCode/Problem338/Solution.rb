# @param {Integer} num
# @return {Integer[]}
def count_bits(num)

  result = Array.new num + 1

  result[0] = 0

  0.upto(num) {|val|
    puts val
  }

end

count_bits 3