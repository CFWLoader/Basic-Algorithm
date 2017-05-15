__author__ = 'CFWLoader'

def load_employee_data path

  src_data = open path, 'r'

  data_collection = []

  for line in src_data

    record = line.split(',')

    trans_rec = {}

    trans_rec['department'] = record[0]
    trans_rec['status'] = record[1]
    trans_rec['min age'] = record[2].to_i
    trans_rec['max age'] = record[3].to_i
    trans_rec['min salary'] = record[4].to_i
    trans_rec['max salary'] = record[5].to_i
    trans_rec['count'] = record[6].to_i

    data_collection << trans_rec

  end

  src_data.close

  data_collection

end

def generate_decision_tree(data_coll)

end


if __FILE__ == $0

  data_collection = load_employee_data('./employees.data')

  for record in data_collection

    for key, val in record.each_pair

      print("(#{key}, #{val})")

    end

    puts

  end

end
