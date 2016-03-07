# @param {Integer[][]} matrix
# @return {Integer}
def longest_increasing_path(matrix)

  if matrix.nil?
    return 0
  end

  rows = matrix.size

  cols = 0

  matrix.each { |arr|
    if !arr.nil? and arr.size > cols
      cols = arr.size
    end }

  cellRecords = Array.new(rows, Array.new(cols, [1, 'N']))

  rowIndex = 0, colIndex = 0

  maxValue = 0, direction = 'N'

  maxPathCount = 1

  matrix.each do |row|

    cols = row.size

    colIndex = 0

    row.each do |cell|

      # Select a max value adjacencies.
      maxValue = 0, direction = 'N'

      if rowIndex - 1 > -1 and matrix[rowIndex - 1][colIndex] > cell and cellRecords[rowIndex - 1][colIndex][0] > maxValue
        maxValue = cellRecords[rowIndex - 1][colIndex][0], direction = 'U'
      end

      if colIndex - 1 > -1 and matrix[rowIndex][colIndex - 1] > cell and cellRecords[rowIndex][colIndex - 1][0] > maxValue
        maxValue = cellRecords[rowIndex][colIndex - 1][0], direction = 'L'
      end

      if rowIndex + 1 < rows and matrix[rowIndex + 1][colIndex] > cell and cellRecords[rowIndex + 1][colIndex][0] > maxValue
        maxValue = cellRecords[rowIndex + 1][colIndex][0], direction = 'D'
      end

      if colIndex + 1 < cols and matrix[rowIndex][colIndex + 1] > cell and cellRecords[rowIndex + 1][colIndex][0] > maxValue
        maxValue = cellRecords[rowIndex][colIndex + 1][0], direction = 'R'
      end

      colIndex += 1

    end

    rowIndex += 1

  end

end


puts longest_increasing_path [[1,1], [1,1]]