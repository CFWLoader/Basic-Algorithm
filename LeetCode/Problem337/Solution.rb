# Definition for a binary tree node.
class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val)
    @val = val
    @left, @right = nil, nil
  end
end

# @param {TreeNode} root
# @return {Integer}
def rob(root)

  root_present, root_absent = rob_max_val root

  root_present > root_absent ? root_present : root_absent

end

def rob_max_val(root)

  if root.nil?
    return 0, 0
  end

  if root.left.nil? and root.right.nil?
    return root.val, 0
  end

  left_present, left_absent = rob_max_val root.left

  right_present, right_absent = rob_max_val root.right

  root_present = root.val + left_absent + right_absent

  root_absent = left_present + right_present

  return root_present, root_absent

end

root1 = TreeNode.new 3

root1.left = TreeNode.new 2

root1.left.right = TreeNode.new 3

root1.right = TreeNode.new 3

root1.right.left = TreeNode.new 1

puts rob root1

root2 = TreeNode.new 3

root2.left = TreeNode.new 4

root2.right = TreeNode.new 5

root2.left.left = TreeNode.new 1

root2.left.right = TreeNode.new 3

root2.right.right = TreeNode.new 1

puts rob root2