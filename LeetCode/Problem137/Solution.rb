# @param {Integer[]} nums
# @return {Integer}
def single_number(nums)

  check_bit = 1

  result = 0

  while check_bit < 2**32

    change_count = 0

    xor_result = 0

    pre_xor = 0

    nums.each { |num|
      xor_result ^= num

      if pre_xor & check_bit != xor_result & check_bit
        change_count += 1
      end
    }

    print "Bit Value: #{check_bit}, Count Value: #{change_count}.\n"

    if change_count != 0 and change_count % 2 == 0
      result |= check_bit
    end

    check_bit *= 2

  end

  result

end

def single_number_alpha(nums)

  xor_result = 0x2f

  nums.each { |num| xor_result ^= num}

  xor_result

end


# puts single_number [8, 2, 11, 39, 5, 11, 39, 39, 2, 8, 11, 8, 2]
#
# puts single_number [1, 1, 1, 2, 3, 4, 4, 4, 2, 2]

puts single_number_alpha [8, 2, 11, 39, 5, 11, 39, 39, 2, 8, 11, 8, 2]

# puts single_number_alpha [1, 1, 1, 2, 3, 4, 4, 4, 2, 2]