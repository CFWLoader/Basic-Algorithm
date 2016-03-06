# @param {String} s
# @return {Boolean}
def is_valid(s)

  if s == nil or s.size == 0 or s.size % 2 != 0
    return false
  end

  strSize = s.size

  stackSize = Integer(s.size / 2)

  stack = Array.new stackSize

  stackTop = -1

  strIndex = 0

  stack[++stackTop] = s[strIndex]

  ++strIndex

  while strIndex < strSize
    if s[strIndex] == '(' or s[strIndex] == '[' or s[strIndex] == '{'
      stack[++stackTop] = s[strIndex]
    else
      if s[strIndex] == ')' and stack[stackTop] != '(' or s[strIndex] == ']' and stack[stackTop] != '[' or s[strIndex] == '}' and stack[stackTop] != '{'
          return false
      end

      --stackTop

    end

    ++strIndex
  end

  if stackTop >= 0
    false
  else
    true
  end

end


puts is_valid '{}{}{}'