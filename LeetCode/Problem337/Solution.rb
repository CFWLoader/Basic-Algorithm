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
  # TODO
  # Writing paper is so painful.
  # Paper skeleton is finished, adding fleshes.
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
