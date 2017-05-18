require 'matrix'

class NaiveBayesianClassifier

  def map_val_to_int vec

    v_map_i = {}

    v_idx = 0

    0.upto(vec.size - 1) {|idx|

      unless v_map_i.include? vec[idx]

        v_map_i[vec[idx]] = v_idx

        v_idx += 1

      end

    }

    v_map_i

  end

  def check_y y

    @y_map = map_val_to_int y

    @y_stt = Array.new @y_map.size, 0

    y.each {|ele|

      @y_stt[@y_map[ele]] += 1

    }

    total_size = y.size

    @y_prob = @y_map.size, 0

    @y_stt.each_with_index {|val, idx|

      @y_prob[idx] = val / total_size.to_f

    }

  end

  def check_x x, y

    @x_map_tbls = Array.new x.column_count

    @x_stt_tbls = Array.new x.column_count

    @x_prob_tbls = Array.new x.column_count

    0.upto(x.column_count - 1) {|cidx|

      x_map = map_val_to_int x.column(cidx)

      @x_map_tbls[cidx] = x_map

      x_stt_tbl = Matrix.build(@y_map.size, x_map.size) {0}

      0.upto(x.row_count - 1) {|ridx|

        y[ridx]

        y_idx = @y_map[y[ridx]]

        x_map_val = x[ridx, cidx]

        x_idx = x_map[x_map_val]

        x_stt_tbl[y_idx, x_idx] += 1

        # x_stt_tbl[@y_map[y[ridx]]][x_map[x[ridx][cidx]]] += 1

      }

      @x_stt_tbls[cidx] = x_stt_tbl

      x_prob_tbl = Matrix.build(@y_map.size, x_map.size) {0}

      x_stt_tbl.each_with_index {|e, row, col|

        x_prob_tbl[row][col] = e/@y_stt[row].to_f

      }

      @x_prob_tbls[cidx] = x_prob_tbl

    }

  end

  def fit x, y

    check_y y

    check_x x, y

  end

  def show_y

    puts @y_prob.inspect

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

  return Matrix.rows(train_collection), target_collection

end


if __FILE__ == $0

  train, target = load_employee_data './employees.data'

  classifier = NaiveBayesianClassifier.new

  classifier.fit train, target

  classifier.show_y

end