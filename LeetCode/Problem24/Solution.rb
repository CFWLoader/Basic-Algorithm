# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end

# @param {ListNode} head
# @return {ListNode}
def swap_pairs(head)

  if head.nil? or head.next.nil?
    return head
  end

  second_node = head

  head = head.next

  third_node = head.next

  head.next = second_node

  second_node.next = third_node.nil? ? third_node.next : third_node

  until third_node.nil? do
    ptr = third_node

    second_node = ptr.next

    if second_node.nil?
      return head
    end

    third_node = second_node.next

    second_node.next = ptr

    ptr.next = third_node.nil? ? third_node.next : third_node

  end

  head
end