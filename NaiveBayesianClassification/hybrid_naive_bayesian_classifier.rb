require './data_opts.rb'
require './statistic_math.rb'

class HybridNaiveBayesianClassifier

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

    if @discrete_spec.nil?

      raise Exception.new 'discrete_spec is nil!'

    end

    @x_map_tbls.each_index {|idx| if @discrete_spec.include? idx then @x_map_tbls[idx] = {} end}

    x.each_with_index { |row, ridx|

      row.each_with_index { |val, cidx|

        # puts "#{cidx}, #{val}, #{@x_map_tbls[cidx].inspect}"

        unless @x_map_tbls[cidx].nil? or @x_map_tbls[cidx].include? val

          max_idx = 0

          @x_map_tbls[cidx].each_value { |idx_val|
            max_idx += 1
          }

          @x_map_tbls[cidx][val] = max_idx

        end

      }

    }

  end

  def build_discrete_var_probability x, y, col_idx

    row_size = x.size

    x_map = @x_map_tbls[col_idx]

    x_stt_tbl = Array.new(@y_map.size)

    x_stt_tbl.each_index {|idx| x_stt_tbl[idx] = Array.new(x_map.size, 0)}

    0.upto(row_size - 1) { |ridx|

      x_stt_tbl[@y_map[y[ridx]]][x_map[x[ridx][col_idx]]] += 1

    }

    @x_stt_tbls[col_idx] = x_stt_tbl

    x_prob_tbl = Array.new(@y_map.size)

    x_prob_tbl.each_index {|idx| x_prob_tbl[idx] = Array.new(x_map.size, 0)}

    x_stt_tbl.each_with_index { |row_val, row|

      row_val.each_with_index { |val, col|

        x_prob_tbl[row][col] = val/@y_stt[row].to_f

      }

    }

    @x_prob_tbls[col_idx] = x_prob_tbl

  end

  def build_continuous_var_probability x, y, col_idx

    x_stt_tbl = Array.new(@y_map.size, 0)

    x_stt_tbl.each_index {|idx| x_stt_tbl[idx] = []}

    x.each_with_index { |val, ridx|

      y_map_idx = @y_map[y[ridx]]

      x_stt_tbl[y_map_idx] << val[col_idx]

    }

    @x_stt_tbls[col_idx] = x_stt_tbl

    x_prob_tbl = Array.new(@y_map.size, 0)

    x_prob_tbl.each_index {|idx| x_prob_tbl[idx] = Array.new 2, 0}

    x_stt_tbl.each_with_index {|arr, arr_idx|

      x_prob_tbl[arr_idx][0] = StatisticMath.average arr

      x_prob_tbl[arr_idx][1] = Math.sqrt StatisticMath.square_deviation arr

    }

    @x_prob_tbls[col_idx] = x_prob_tbl

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

    column_size = x[0].size

    build_x_map_tbls x

    @x_stt_tbls = Array.new column_size

    @x_prob_tbls = Array.new column_size

    0.upto(column_size - 1) { |cidx|

      if @discrete_spec.include? cidx

        build_discrete_var_probability x, y, cidx

      else

        build_continuous_var_probability x, y, cidx

      end

    }

  end

  def fit x, y, discrete_spec = nil

    @discrete_spec = if discrete_spec.nil? then [] else discrete_spec end

    check_y y

    check_x x, y

  end

  def predict rec

    cls_idx = nil

    max_prob_val = 0

    @y_prob.each_with_index {|y_val, y_idx|

      cls_var = y_val

      @x_prob_tbls.each_with_index {|tbl, tbl_idx|

        if @discrete_spec.include? tbl_idx

          x_idx = @x_map_tbls[tbl_idx][rec[tbl_idx]]

          if x_idx.nil?

            cls_var = 0

          else

            cls_var *= tbl[y_idx][x_idx]

          end

        else

          cls_var *= StatisticMath.gaussian_value tbl[y_idx][0], tbl[y_idx][1], rec[tbl_idx]

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

  def show_x_ana_data

    puts 'X map tables:'

    puts @x_map_tbls

    puts 'X statistic tables:'

    puts @x_stt_tbls.inspect

    puts 'X probability tables:'

    puts @x_prob_tbls.inspect

  end

end


def test_case1

  train_set, target_set = load_employee_regened_data './employees_regened.data'

  hnbc = HybridNaiveBayesianClassifier.new

  hnbc.fit train_set, target_set, [0]

  # hnbc.build_x_map_tbls train_set

  puts hnbc.predict train_set[0]

end


def test_case2

  train, target = load_employee_regened_data './employees_regened.data'

  classifier = HybridNaiveBayesianClassifier.new

  # classifier.show_y
  #
  # classifier.show_x_ana_data

  right_count = 0

  target.each_with_index {|val, idx|

    k_fold_train = train.clone

    k_fold_train.delete_at idx

    k_fold_target = target.clone

    k_fold_target.delete_at idx

    classifier.fit k_fold_train, k_fold_target, [0]

    if val == classifier.predict(train[idx])

      right_count += 1

    end

  }

  puts "Totoal: #{train.size}, Right: #{right_count}, Correctness Ratio: #{right_count / train.size.to_f}"

end


if $0 == __FILE__

  test_case2

end