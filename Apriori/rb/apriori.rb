require 'set'

class Apriori
  
  def initialize records, min_sup = 1

    @records = records

    @min_sup = min_sup

  end

  def find_frequent_1_itemsets

    itemsets = []

    @records.each {|record|

      record.each{|ele|

        ele_s = Set.new([ele])

        unless itemsets.include? ele_s

          itemsets << ele_s

        end
      }

    }

    frozen_itemsets = []

    itemsets.each {|s|

      frozen_itemsets << s.freeze

    }

    itemsets_count = {}

    frozen_itemsets.each{|can|

      @records.each {|rec|

        if can.subset? rec

          if itemsets_count.has_key? can

            itemsets_count[can] += 1

          else

            itemsets_count[can] = 1

          end

        end

      }

    }

    qual_itemsets = {}

    itemsets_count.each_pair{|k, v|

      if v >= @min_sup

        qual_itemsets[k] = v

      end

    }

    qual_itemsets

  end

  def has_infrequent_set un_set, frozen_set

    unfrozen_un = Set.new un_set

    unfrozen_un.each {|ele|

      sub_k_1_set = Set.new unfrozen_un

      sub_k_1_set.delete ele

      sub_k_1_set.freeze

      unless frozen_set.include? sub_k_1_set

        return true

      end
    }

    false

  end
  
  def apriori_gen lk

    frozen_set = Set.new

    lk.each_key {|key|

      frozen_set << key

    }

    if frozen_set.size <= 0

      return Set.new

    end

    set_size = 0

    frozen_set.each {|ele| set_size = ele.size + 1; break}

    gen_set = Set.new

    frozen_set.each{|ele1|

      frozen_set.each{|ele2|

        unless ele1.subset? ele2 and ele1.superset? ele2

          un_set = ele1 + ele2

          un_set.freeze

          unless un_set.frozen?
            raise Exception 'Set hasn\'t been frozen!'
          end

          if un_set.size == set_size and not gen_set.include? un_set and not self.has_infrequent_set un_set, frozen_set

            gen_set << un_set

          end

        end

      }

      gen_set
    }

  end

  def generate_frequent_itemsets

    l1 = find_frequent_1_itemsets

    final_sets = [l1]

    k = 1

    while final_sets[k - 1].size > 0

      puts "Generating from #{k - 1}, collection type: #{final_sets[k - 1].class}."

      ck = apriori_gen final_sets[k - 1]

      puts "Candidate[#{k}] size: #{ck.size}."

      count_set = {}

      verfied_count_set = {}

      ck.each {|can|

        count_set[can] = 0

        @records.each {|record|

          if can.subset? record

            count_set[can] += 1

          end

        }

      }

      count_set.each_pair {|key, v|

        if v >= @min_sup

          verfied_count_set[key] = v

        end

      }

      final_sets << Hash.new(verfied_count_set)

      count_set.clear

      verfied_count_set.clear

      k += 1

    end

    final_sets

  end

end

def translate_record record

  items = Set.new

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

apri = Apriori.new vote_records, 1

fre_set = apri.generate_frequent_itemsets

for layer in fre_set

  layer.each_pair{|k, v|

    print '{'
    k.each {|ele| print ele}
    print '}'

    print ':',v, ' '

  }

  puts
end

# result = apri.find_frequent_1_itemsets
#
# result.each_pair{|k, v|
#
#   print '{'
#   for ele in k
#     print ele, ','
#   end
#   print '}'
#
#   print v
#
#   puts
#
# }