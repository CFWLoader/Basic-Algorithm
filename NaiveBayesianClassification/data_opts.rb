def regenerate_employee_data path

  src_data = open path, 'r'

  regened = open './employees_regened.data', 'w'

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

    rec_count = record[4].to_i

    age_range = record[2].split('-')

    age_lower_bound = age_range[0].to_i

    age_upper_bound = age_range[1].to_i

    salary_range = record[3].split('-')

    salary_lower_bound = salary_range[0].to_i

    salary_upper_bound = salary_range[1].to_i

    1.upto(rec_count) {

      regened.write "#{record[0]},#{Random.rand age_lower_bound..age_upper_bound},#{Random.rand salary_lower_bound..salary_upper_bound},#{record[1]}\n"

      #puts "Record:[dept:#{record[0]}, age:#{Random.rand age_lower_bound..age_upper_bound}, salary:#{Random.rand salary_lower_bound..salary_upper_bound}, status:#{record[1]}]"

    }

    # train_collection << [record[0], record[2], record[3]]
    #
    # target_collection << record[1]

  }

  src_data.close

  regened.close

  return train_collection, target_collection

end


def load_employee_regened_data path

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

    train_collection << [record[0], record[1].to_i, record[2].to_i]

    target_collection << record[3]

  }

  src_data.close

  return train_collection, target_collection

end


if $0 == __FILE__

  regenerate_employee_data './employees.data'

end