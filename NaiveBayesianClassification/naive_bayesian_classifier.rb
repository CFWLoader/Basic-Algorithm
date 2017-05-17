require 'matrix'

class NaiveBayesianClassifier

  def check_y y

    @y_stt_hash = {}

    y.each {|ele|

      if @y_stt_hash.key? ele

        @y_stt_hash[ele] += 1

      else

        @y_stt_hash[ele] = 1

      end

    }

    total_size = y.size

    @y_prob_hash = {}

    @y_stt_hash.each_pair {|k, v|

      @y_prob_hash[k] = v / total_size.to_f

    }

  end

  def check_x x

    @x_stt_tbls = []

    0.upto(x.column_count - 1) {|cidx|

      @y_stt_hash.each_key {|key|

        xj_stt_tbl = {}

        x.column(j) {|xj_key|

          tpl = (xj_key, key)

          if xj_stt_tbl.has_key? tpl

            xj_stt_tbl[tpl]

          end

        }

      }

    }

  end

  def fit x, y

    check_y y

    check_x x

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

end