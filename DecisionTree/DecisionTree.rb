__author__ = 'CFWLoader'


require 'set'


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

    @class_tag_name = class_tag_name

    if attr_list.nil?

      @attr_list = gen_attr_list dataset

    else

      @attr_list = attr_list

    end

    @root = DTNode.new dataset

  end

  def gen_attr_list dataset

    attr_list = Set.new

    dataset.each{|record|

      record.each_key { |key|

        unless key == @class_tag_name or attr_list.include? key

          attr_list << key

        end
      }

    }

    attr_list

  end

  def same_class? data_partition

    class_val = data_partition[0][@class_tag_name]

    data_partition.each { |record| if record[@class_tag_name] != class_val then return false end }

    true

  end

  def majority_class_value data_partition

    class_statistic = {}

    data_partition.each { |record|

      if class_statistic.include? record[@class_tag_name]

        class_statistic[record[@class_tag_name]] += 1

      else

        class_statistic[record[@class_tag_name]] = 1

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

  def entropy data_partition, attr = nil

    if attr.nil?

      class_statistic = {}

      data_partition.each { |record|

        if class_statistic.include? record[@class_tag_name]

          class_statistic[record[@class_tag_name]] += 1

        else

          class_statistic[record[@class_tag_name]] = 1

        end

      }

      data_entropy = 0

      total_count = data_partition.size

      class_statistic.each_value {|val|

        propability = val / total_count.to_f

        data_entropy += propability * Math.log2(propability)

      }

      return -data_entropy

    end

    attr_hash = {}

    data_partition.each { |record|

      attr_val = record[attr]

      if attr_hash.include? attr_val

        attr_hash[attr_val][0] += 1

        attr_hash[attr_val] << record

      else

        attr_hash[attr_val] = [1, record]

      end

    }

    total_count = data_partition.size

    attr_data_entropy = 0

    attr_hash.each_value {|val|

      attr_data_entropy += val[0] / total_count.to_f * entropy(val[1..(val.size - 1)])

    }

    attr_data_entropy

  end

  def max_entropy_gain_attr data_paritition

    ori_entropy = entropy nil, data_paritition

    max_entropy_gain = 0

    attr_val = nil

    @attr_list.each {|attr|

      tmp_entropy_gain = ori_entropy - entropy(attr, data_paritition)

      if max_entropy_gain < tmp_entropy_gain

        max_entropy_gain = tmp_entropy_gain

        attr_val = attr

      end

    }

    attr_val

  end

  def gen_decision_tree data_partition

    if data_partition.size < 1
      return nil
    end

    if same_class? data_partition

      return DTNode.new data_partition, data_partition[0][class_tag_name]

    end

    if @attr_list.empty?

      return DTNode.new data_partition, majority_class_value(data_partition)

    end

    pri_attr = max_entropy_gain_attr data_partition

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


def load_test_data path

  src_data = open path, 'r'

  data_collection = []

  src_data.each { |line|

    record = line.chomp.split(',')

    trans_rec = {}

    trans_rec['attr1'] = record[0]
    trans_rec['attr2'] = record[1]
    trans_rec['status'] = record[2]

    data_collection << trans_rec

  }

  src_data.close

  data_collection

end


if __FILE__ == $0

  test_dc = load_test_data './test.data'

  dtree = DecisionTree.new test_dc, 'status'

  all_entropy = dtree.entropy test_dc

  age_entropy = dtree.entropy test_dc, 'attr2'

  puts all_entropy - age_entropy

  # data_collection = load_employee_data('./employees.data')
  #
  # data_collection.each { |record|
  #
  #   #puts record.inspect
  #
  #   record.each_pair { |key, val|
  #
  #     print "(#{key}, #{val})"
  #
  #   }
  #
  #   puts
  #
  # }

end
