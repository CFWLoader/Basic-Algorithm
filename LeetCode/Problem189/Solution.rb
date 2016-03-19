# @param {Integer[]} nums
# @param {Integer} k
# @return {Void} Do not return anything, modify nums in-place instead.
def rotate(nums, k)

  if nums.nil? or nums.size == 1 or k % nums.size == 0
    return
  end

  array_length = nums.size

  count = 0

  source_index = 0

  buffer_value = nums[source_index]

  target_index = (source_index + k) % array_length

  while count < array_length

    # print "S: #{source_index}-#{nums[source_index]}, T: #{target_index}-#{nums[target_index]}, B: #{buffer_value}\n"

    nums[target_index] = buffer_value

    source_index = target_index

    target_index = (source_index + k) % array_length

    buffer_value = nums[target_index]

    print "S: #{source_index}-#{nums[source_index]}, T: #{target_index}-#{nums[target_index]}, B: #{buffer_value}\n"

    # nums[target_index] = nums[source_index]

    count += 1
  end
end

source = [1, 2, 3, 4, 5, 6, 7]

rotate source, 3

print source

puts