class HybridBayesianClassifier

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

  def build_x_map_tbls x, discrete_spec

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

  def fit x, y, discrete_spec

  end

  def predict rec



  end

end


if $0 == __FILE__

end