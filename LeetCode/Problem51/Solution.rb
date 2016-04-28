# @param {Integer} n
# @return {String[][]}
def solve_n_queens(n)

  coordinates = Array.new n

  result_set = Array.new

  0.upto(n - 1) {|num|

    coordinates[0] = num

    if get_a_solution coordinates
      result_set << construct_chessboard(coordinates)
    end
  }

  result_set
end

def get_a_solution(coordinates)

  bound = coordinates.size

  index = 1

  while index < bound

    index += 1
  end

  true

end

def construct_chessboard(coordinates)

  chessboard = Array.new coordinates.size

  coordinates.each_with_index { |col, row|

    chessboard[row] = Array.new coordinates.size, '.'

    chessboard[row][col] = 'Q'

  }

  chessboard
end

result = solve_n_queens 3

result.each {|chessboard|
  print chessboard
  puts
}