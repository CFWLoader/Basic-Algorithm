# Definition for a binary tree node.
class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val)
    @val = val
    @left, @right = nil, nil
  end
end

# @param {TreeNode} root
# @param {TreeNode} p
# @param {TreeNode} q
# @return {TreeNode}
def lowest_common_ancestor(root, p, q)

  if root.nil? or p.nil? or q.nil?
    return nil
  end

  if root.val > p.val and root.val > q.val
    return lowest_common_ancestor root.left, p, q
  elsif root.val < p.val and root.val < q.val
    return lowest_common_ancestor root.right, p, q
  end

  root

end