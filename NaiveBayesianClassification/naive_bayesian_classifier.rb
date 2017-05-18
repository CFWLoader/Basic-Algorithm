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

    @y_prob = Array.new @y_map.size, 0

    @y_stt.each_with_index { |val, idx|

      @y_prob[idx] = val / total_size.to_f

    }

  end

  def check_x x, y

    row_size = x.size

    column_size = x[0].size

    build_x_map_tbls x

    @x_stt_tbls = Array.new column_size

    @x_prob_tbls = Array.new column_size

    0.upto(column_size - 1) { |cidx|

      x_map = @x_map_tbls[cidx]

      x_stt_tbl = Array.new(@y_map.size)

      x_stt_tbl.each_index {|idx| x_stt_tbl[idx] = Array.new(x_map.size, 0)}

      0.upto(row_size - 1) { |ridx|

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

    cls_idx = nil

    max_prob_val = 0

    @y_prob.each_with_index {|y_val, y_idx|

      cls_var = y_val

      @x_prob_tbls.each_with_index {|tbl, tbl_idx|

        x_idx = @x_map_tbls[tbl_idx][rec[tbl_idx]]

        if x_idx.nil?

          cls_var = 0

        else

          cls_var *= tbl[y_idx][x_idx]

        end

        # cls_var *= tbl[y_idx][@x_map_tbls[tbl_idx][rec[tbl_idx]]]

      }

      if max_prob_val < cls_var

        max_prob_val = cls_var

        cls_idx = y_idx

      end

    }

    if cls_idx.nil?

      return 'Failed to predict this record.'

    end

    @y_map.each_pair {|key, val|

      if val == cls_idx

        return key

      end

    }

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


def test_case1

  train, target = load_employee_data './employees.data'

  classifier = NaiveBayesianClassifier.new

  classifier.fit train, target

  # classifier.show_y
  #
  # classifier.show_x_ana_data

  right_count = 0

  target.each_with_index {|val, idx|

    if val == classifier.predict(train[idx])

      right_count += 1

    end

  }

  puts "Correctness Ratio: #{right_count / train.size.to_f}"

end


def test_case2

  train, target = load_employee_data './employees.data'

  classifier = NaiveBayesianClassifier.new

  # classifier.show_y
  #
  # classifier.show_x_ana_data

  right_count = 0

  target.each_with_index {|val, idx|

    k_fold_train = train.clone

    k_fold_train.delete_at idx

    k_fold_target = target.clone

    k_fold_target.delete_at idx

    classifier.fit k_fold_train, k_fold_target

    if val == classifier.predict(train[idx])

      right_count += 1

    end

  }

  puts "Correctness Ratio: #{right_count / train.size.to_f}"

end


def test_case3

  train, target = load_employee_data './employees.data'

  classifier = NaiveBayesianClassifier.new

  classifier.fit train, target

  # classifier.show_y
  #
  # classifier.show_x_ana_data

  right_count = 0

  target.each_with_index {|val, idx|

    if val == classifier.predict(train[idx])

      right_count += 1

    end

  }

  puts "Correctness Ratio: #{right_count / train.size.to_f}"

  puts "#{classifier.predict ['systems', '26-30', '46000-50000']}"

end


if __FILE__ == $0

  test_case3

end