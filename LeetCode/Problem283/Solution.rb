# @param {Integer[]} nums
# @return {Void} Do not return anything, modify nums in-place instead.
def move_zeroes(nums)

  zero_count = 0

  nums.each{|n| if n == 0 then zero_count += 1 end}

  bound = nums.size


end