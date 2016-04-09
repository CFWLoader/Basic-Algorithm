# @param {Integer[]} nums
# @return {Integer[]}
def product_except_self(nums)

  if nums.nil? or nums.size < 1
    return []
  end

  result_set = Array.new nums.size, 1

  nums.each_with_index { |val, idx|

    print "#{val}, #{idx}\n"

  }

  result_set
end