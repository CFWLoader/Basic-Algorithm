# @param {Integer} n
# @return {String[][]}
def solve_n_queens(n)

  coordinates = Array.new n, 0

  result_set = Array.new

  0.upto(n - 1) { |num|

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

  placed = 1

  while placed > 0 and placed < coordinates.size

    col_val = 0

    while col_val < bound
      coordinates[placed] = col_val

      if is_valid coordinates, placed
        placed += 1
      else
        placed -= 1
      end
    end

    index += 1
  end

  placed == coordinates.size

end

def is_valid(coordinates, target)

  0.upto(target - 1) { |row|
    if coordinates[target] == coordinates[row] || (target - row).abs == (coordinates[target] - coordinates[row])
      return false
    end
  }

  true

end

def construct_chessboard(coordinates)

  chessboard = Array.new coordinates.size

  coordinates.each_with_index { |col, row|

    chessboard[row] = '.' * coordinates.size

    chessboard[row][col] = 'Q'

  }

  chessboard
end

result = solve_n_queens 4

result.each { |chessboard|
  print chessboard
  puts
}