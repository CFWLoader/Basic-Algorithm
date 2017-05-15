__author__ = 'CFWLoader'


class DTNode

  def initialize class_tag, data_partition

    @class_tag = class_tag

    @data_partition = data_partition

    @child_nodes = []

  end

end


class DecisionTree

  def initialize dataset, attr_list = nil

    @dataset = dataset

    if attr_list.nil?

      @attr_list = gen_attr_list dataset

    else

      @attr_list = attr_list

    end

  end

  def gen_attr_list dataset

    attr_list = Set.new

    dataset.each{|record|

      record.each_key { |key|

        unless attr_list.include? key

          attr_list.add key

        end
      }

    }

    attr_list

  end

end


def load_employee_data path

  src_data = open path, 'r'

  data_collection = []

  src_data.each { |line|

    record = line.split(',')

    trans_rec = {}

    trans_rec['department'] = record[0]
    trans_rec['status'] = record[1]
    trans_rec['age'] = record[2]
    trans_rec['salary'] = record[3]
    trans_rec['count'] = record[4]

    data_collection << trans_rec

  }

  src_data.close

  data_collection

end

def generate_decision_tree(data_coll)

end


if __FILE__ == $0

  data_collection = load_employee_data('./employees.data')

  data_collection.each { |record|

    record.each_pair { |key, val|

      print("(#{key}, #{val})")

    }

    puts

  }

end
