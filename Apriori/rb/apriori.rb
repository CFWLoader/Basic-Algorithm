class Apriori

  def initialize records, min_sup = 1

    @records = records

    @min_sup = min_sup

  end

  def find_frequent_1_itemsets

    itemsets = []

    @records.each {|record|

      record.each{|ele|

        unless itemsets.include? [ele]

          itemsets << [ele]

        end
      }

    }

    frozen_itemsets = []

    itemsets.each {|s|

      frozen_itemsets << s.freeze

    }

  end

end

def translate_record record

  items = []

  if record[0] == 'republican'

    items << 'rep'

  elsif record[0] == 'democrat'

    items. << ('demo')

  end

  if record[1] == 'y'
    items. << ('hci') # handicapped-infants

  elsif record[1] == 'n'

    items. << ('hci-n')

  end

  if record[2] == 'y'

    items. << ('wpcs') # water-project-cost-sharing

  elsif record[2] == 'n'

    items. << ('wpcs-n')

  end

  if record[3] == 'y'

    items. << ('aotbr') # adoption-of-the-budget-resolution

  elsif record[3] == 'n'

    items. << ('aotbr-n')

  end

  if record[4] == 'y'

    items. << ('pff') # physician-fee-freeze

  elsif record[4] == 'n'

    items. << ('pff-n')

  end

  if record[5] == 'y'

    items. << ('esa') # el-salvador-aid

  elsif record[5] == 'n'

    items. << ('esa-n')

  end

  if record[6] == 'y'

    items. << ('rgis') # religious-groups-in-schools

  elsif record[6] == 'n'

    items. << ('rgis-n')

  end

  if record[7] == 'y'

    items. << ('astb') # anti-satellite-test-ban

  elsif record[7] == 'n'

    items. << ('astb-n')

  end

  if record[8] == 'y'

    items. << ('atnc') # aid-to-nicaraguan-contras

  elsif record[8] == 'n'

    items. << ('atnc-n')

  end

  if record[9] == 'y'

    items. << ('mxm') # mx-missile

  elsif record[9] == 'n'

    items. << ('mxm-n')

  end

  if record[10] == 'y'

    items. << ('imm') # immigration

  elsif record[10] == 'n'

    items. << ('imm-n')

  end

  if record[11] == 'y'

    items. << ('scc') # synfuels-corporation-cutback

  elsif record[11] == 'n'

    items. << ('scc-n')

  end

  if record[12] == 'y'

    items. << ('es') # education-spending

  elsif record[12] == 'n'

    items. << ('es-n')

  end

  if record[13] == 'y'

    items. << ('srts') # superfund-right-to-sue

  elsif record[13] == 'n'

    items. << ('srts-n')

  end

  if record[14] == 'y'

    items. << ('cri') # crime

  elsif record[14] == 'n'

    items. << ('cri-n')

  end

  if record[15] == 'y'

    items. << ('dfe') # duty-free-exports

  elsif record[15] == 'n'

    items. << ('dfe-n')

  end

  if record[16] == 'y'
    items. << ('eaasa') # export-administration-act-south-africa

  elsif record[16] == 'n'

    items. << ('eaasa-n')

  end

  items

end

def load_data file_path

  src_data = open(file_path)

  votes_records = []

  src_data.each {|line|

    votes_records. << (translate_record(line.split ','))

  }

  src_data.close

  votes_records

end

vote_records = load_data './house-votes-84.data'

vote_records.each {|record|

  print record

  puts

}