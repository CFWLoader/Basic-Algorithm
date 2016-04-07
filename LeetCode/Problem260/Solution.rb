# @param {Integer[]} nums
# @return {Integer[]}
def single_number(nums)

  if nums.nil? or nums.size < 1
    return []
  end

  xor_result = 0

  # xnor_result = Integer.

  nums.each {|num|
    xor_result ^= num

    # xnor_result &= num
  }

  [xor_result]

end


result = single_number [1, 2, 1, 3, 2, 5]

print result

puts
