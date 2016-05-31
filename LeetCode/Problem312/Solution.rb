# @param {Integer[]} nums
# @return {Integer}
def max_coins(nums)

  if nums.nil? or nums.size < 1
    return 0
  end

  nums_size = nums.size

  nums.unshift(1)

  nums << 1

  dp_matrix = Array.new nums_size

  0.upto(nums_size) do |idx| dp_matrix[idx] = Array.new nums_size, 0 end

  1.upto(nums_size) {|len|

    l = 1

    while l + len - 1 <= nums_size

      r = l + len - 1

      l.upto(r) {|k|

        dp_left = dp_matrix[l][r]; dp_right = dp_matrix[l][k - 1] + dp_matrix[k + 1][r] + nums[l - 1] * nums[r + 1] * nums[k]

        dp_matrix[l][r] = dp_left > dp_right ? dp_left : dp_right

      }

      l += 1

    end
  }

  dp_matrix[1][nums_size]

end

puts max_coins [3, 1, 5, 8]