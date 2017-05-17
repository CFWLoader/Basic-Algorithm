__author__ = 'CFWLoader'


require 'set'


class DTNode

  def initialize data_partition = nil, class_tag = nil, attr_tag_name = nil

    @class_tag = class_tag

    @data_partition = data_partition

    @attr_tag_name = attr_tag_name

    @child_nodes = {}

  end

  def data_partition= val

    @data_partition = val

  end

  def data_partition

    @data_partition

  end

  def class_tag= val

    @class_tag = val

  end

  def class_tag

    @class_tag

  end

  def attr_tag_name= val

    @attr_tag_name = val

  end

  def attr_tag_name

    @attr_tag_name

  end

  def add_child_node trait_value, child_node

    @child_nodes[trait_value] = child_node

  end

  def get_child_node_by_attr_val attr_val

    if @child_nodes.has_key? attr_val

      @child_nodes[attr_val]

    else

      nil

    end

  end

end


class CountDecisionTree

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

        unless key == @class_tag_name or key == 'count' or attr_list.include? key

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

      total_count = 0

      class_statistic = {}

      data_partition.each { |record|

        if class_statistic.include? record[@class_tag_name]

          class_statistic[record[@class_tag_name]] += record['count']

        else

          class_statistic[record[@class_tag_name]] = record['count']

        end

        total_count += record['count']

      }

      data_entropy = 0

      #total_count = data_partition.size

      class_statistic.each_value {|val|

        propability = val / total_count.to_f

        data_entropy += propability * Math.log2(propability)

      }

      return -data_entropy

    end

    attr_hash = {}

    total_count = 0

    data_partition.each { |record|

      attr_val = record[attr]

      record_count = record['count']

      if attr_hash.include? attr_val

        attr_hash[attr_val][0] += record_count

        attr_hash[attr_val] << record

      else

        attr_hash[attr_val] = [record_count, record]

      end

      total_count += record_count

    }

    attr_data_entropy = 0

    attr_hash.each_pair {|key, val|

      attr_data_entropy += val[0] / total_count.to_f * entropy(val[1..(val.size - 1)])

      puts "Attribute '#{key}' scores: #{attr_data_entropy}."

      val.delete_at 0

    }

    return attr_data_entropy, attr_hash

  end

  def max_entropy_gain_attr data_partition, attr_list

    ori_entropy = entropy data_partition

    max_entropy_gain = 0

    attr_val = nil

    attr_val_partition = nil

    attr_list.each {|attr|

      tmp_entropy_gain, tmp_attr_val_partition = entropy(data_partition, attr)

      tmp_entropy_gain = ori_entropy - tmp_entropy_gain

      if max_entropy_gain < tmp_entropy_gain

        max_entropy_gain = tmp_entropy_gain

        attr_val = attr

        attr_val_partition = tmp_attr_val_partition

      end

    }

    return attr_val, attr_val_partition

  end

  def gen_decision_tree data_partition, attr_list

    if same_class? data_partition

      return DTNode.new data_partition, data_partition[0][@class_tag_name]

    end

    if @attr_list.empty?

      return DTNode.new data_partition, majority_class_value(data_partition)

    end

    ret_node = DTNode.new data_partition

    pri_attr, partitions_under_attr = max_entropy_gain_attr data_partition, attr_list

    ret_node.attr_tag_name= pri_attr

    partitions_under_attr.each_pair {|key, val|

      if val.size < 1

        new_child = DTNode.new val, majority_class_value(data_partition)

      else

        new_attr_list= attr_list.clone

        new_attr_list.delete_if {|ele| ele == key}

        new_child = gen_decision_tree val, new_attr_list

      end

      ret_node.add_child_node key, new_child

    }

    ret_node

  end

  def fit

    @root = gen_decision_tree @dataset, @attr_list

  end

  def classify record

    iter = @root

    while iter.class_tag.nil?

      iter = iter.get_child_node_by_attr_val record[iter.attr_tag_name]

      if iter.nil?

        return 'Failed to classify the record.'

      end

    end

    iter.class_tag

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
    trans_rec['count'] = record[4].to_i

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


def test_cast1

  test_dc = load_test_data './test.data'

  dtree = DecisionTree.new test_dc, 'status'

  all_entropy = dtree.entropy test_dc

  age_entropy, data_partitions = dtree.entropy test_dc, 'attr2'

  puts all_entropy - age_entropy

  data_partitions.each {|element|
    puts element.inspect
  }

end


def test_case2

  data_collection = load_employee_data('./employees.data')

  data_collection.each { |record|

    #puts record.inspect

    record.each_pair { |key, val|

      print "(#{key}, #{val})"

    }

    puts

  }

end


def test_case3

  data_collection = load_employee_data('./employees.data')

  dtree = DecisionTree.new data_collection, 'status'

  dtree.fit

  correct_count = 0

  data_collection.each {|record|

    if record['status'] == dtree.classify(record)

      correct_count += 1

    end

  }

  puts "Correctness Ratio: #{100 * correct_count/data_collection.size.to_f}%."

end

def test_case4

  data_collection = load_employee_data('./employees.data')

  dtree = CountDecisionTree.new data_collection, 'status'

  dtree.fit

  test_record = {'department' => 'systems', 'age' => '26-30', 'salary' => '46000-50000'}

  result = dtree.classify test_record

  puts result

end


if __FILE__ == $0

  test_case4

end
