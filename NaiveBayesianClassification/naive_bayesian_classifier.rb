class NaiveBayesianClassifier

  def map_val_to_int vec

    v_map_i = {}

    v_idx = 0

    0.upto(vec.size - 1) { |idx|

      unless v_map_i.include? vec[idx]

        v_map_i[vec[idx]] = v_idx

        v_idx += 1

      end

    }

    v_map_i

  end

  def build_x_map_tbls x

    @x_map_tbls = Array.new(x[0].size)

    @x_map_tbls.each_index {|idx| @x_map_tbls[idx] = {}}

    x.each_with_index { |row, ridx|

      row.each_with_index { |val, cidx|

        # puts "#{cidx}, #{val}, #{@x_map_tbls[cidx].inspect}"

        unless @x_map_tbls[cidx].include? val

          max_idx = 0

          @x_map_tbls[cidx].each_value { |idx_val|
            max_idx += 1
          }

          @x_map_tbls[cidx][val] = max_idx

        end

      }

    }

  end

  def check_y y

    @y_map = map_val_to_int y

    @y_stt = Array.new @y_map.size, 0

    y.each { |ele|

      @y_stt[@y_map[ele]] += 1

    }

    total_size = y.size

    @y_prob = @y_map.size, 0

    @y_stt.each_with_index { |val, idx|

      @y_prob[idx] = val / total_size.to_f

    }

  end

  def check_x x, y

    row_size = x.size

    column_size = x[0].size

    # @x_map_tbls = Array.new column_size

    build_x_map_tbls x

    @x_stt_tbls = Array.new column_size

    @x_prob_tbls = Array.new column_size

    0.upto(column_size - 1) { |cidx|

      # x_map = map_val_to_int x[0].size
      #
      # @x_map_tbls[cidx] = x_map
      x_map = @x_map_tbls[cidx]

      x_stt_tbl = Array.new(@y_map.size)

      x_stt_tbl.each_index {|idx| x_stt_tbl[idx] = Array.new(x_map.size, 0)}

      0.upto(row_size - 1) { |ridx|

        # y_idx = @y_map[y[ridx]]
        #
        # x_map_val = x[ridx][cidx]
        #
        # x_idx = x_map[x_map_val]
        #
        # x_stt_tbl[y_idx][x_idx] += 1

        x_stt_tbl[@y_map[y[ridx]]][x_map[x[ridx][cidx]]] += 1

      }

      @x_stt_tbls[cidx] = x_stt_tbl

      x_prob_tbl = Array.new(@y_map.size)

      x_prob_tbl.each_index {|idx| x_prob_tbl[idx] = Array.new(x_map.size, 0)}

      x_stt_tbl.each_with_index { |row_val, row|

        row_val.each_with_index { |val, col|

          x_prob_tbl[row][col] = val/@y_stt[row].to_f

        }

      }

      @x_prob_tbls[cidx] = x_prob_tbl

    }

  end

  def fit x, y

    if x.size < 0 or y.size < 0 or x.size != y.size

      raise Exception 'Empty data set or the rows of attribute dataset is not equals to target dataset.'

    end

    check_y y

    check_x x, y

  end

  def show_y

    puts 'y map:'

    puts @y_map.inspect

    puts 'y statistic:'

    puts @y_stt.inspect

    puts 'y probability:'

    puts @y_prob.inspect

  end

  def show_x_ana_data

    puts 'X map tables:'

    puts @x_map_tbls

    puts 'X statistic tables:'

    puts @x_stt_tbls.inspect

    puts 'X probability tables:'

    puts @x_prob_tbls.inspect

  end

  def predict rec

  end

end


def load_employee_data path

  src_data = open path, 'r'

  train_collection = []

  target_collection = []

  src_data.each { |line|

    record = line.chomp.split(',')

    # trans_rec = []
    # trans_rec['department'] = record[0]
    # trans_rec['status'] = record[1]
    # trans_rec['age'] = record[2]
    # trans_rec['salary'] = record[3]
    # trans_rec['count'] = record[4]

    train_collection << [record[0], record[2], record[3]]

    target_collection << record[1]

  }

  src_data.close

  return train_collection, target_collection

end


if __FILE__ == $0

  train, target = load_employee_data './employees.data'

  classifier = NaiveBayesianClassifier.new

  classifier.fit train, target

  classifier.show_y

  classifier.show_x_ana_data

end