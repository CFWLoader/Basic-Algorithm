__author__ = 'CFWLoader'


class DTNode

  def initialize data_partition, class_tag = nil

    @class_tag = class_tag

    @data_partition = data_partition

    @child_nodes = []

  end

  def add_child_node child_node

    @child_nodes << child_node

  end

end


class DecisionTree

  def initialize dataset, class_tag_name, attr_list = nil

    @dataset = dataset

    if attr_list.nil?

      @attr_list = gen_attr_list dataset, class_tag_name

    else

      @attr_list = attr_list

    end

    @root = DTNode.new dataset

  end

  def gen_attr_list dataset, class_tag_name

    attr_list = Set.new

    dataset.each{|record|

      record.each_key { |key|

        unless key == class_tag_name or attr_list.include? key

          attr_list << key

        end
      }

    }

    attr_list

  end

  def same_class? data_partition, class_tag_name

    class_val = data_partition[0][class_tag_name]

    data_partition.each { |record| if record[class_tag_name] != class_val then return false end }

    true

  end

  def majority_class_value data_partition, class_tag_name

    class_statistic = {}

    data_partition.each { |record|

      if class_statistic.include? record[class_tag_name]

        class_statistic[record[class_tag_name]] += 1

      else

        class_statistic[record[class_tag_name]] = 1

      end

    }

    max_count = 0

    mark_class_value = nil

    class_statistic.each_pair{|k, v|

      if v > max_count

        max_count = v

        mark_class_value = k

      end
    }

    mark_class_value

  end

  def fit

  end

  def gen_decision_tree data_partition, class_tag_name

    if data_partition.size < 1
      return nil
    end

    if same_class? data_partition, class_tag_name

      return DTNode.new data_partition, data_partition[0][class_tag_name]

    end

    if @attr_list.empty?

      return DTNode.new data_partition, majority_class_value(data_partition, class_tag_name)

    end

  end

end


def load_employee_data path

  src_data = open path, 'r'

  data_collection = []

  src_data.each { |line|

    record = line.chomp.split(',')

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


if __FILE__ == $0

  data_collection = load_employee_data('./employees.data')

  data_collection.each { |record|

    #puts record.inspect

    record.each_pair { |key, val|

      print "(#{key}, #{val})"

    }

    puts

  }

end
