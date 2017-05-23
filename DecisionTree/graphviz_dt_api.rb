module Graphviz_DT_API

  @@NODE_NUMBERING = 1

  def self.clear

    @@NODE_NUMBERING = 1

  end

  def self.print_dt node, layer = 0, parent_num = 0, **oth_para

    cur_num = @@NODE_NUMBERING

    if node.class_tag.nil?

      print "(#{cur_num}, #{node.attr_tag_name}, #{node.child_nodes.keys.inspect}, #{parent_num}, #{oth_para[:node_val]})\n"

    else

      print "(#{cur_num}, #{node.class_tag}, #{parent_num}, #{oth_para[:node_val]})\n"

    end

    @@NODE_NUMBERING += 1

    node.child_nodes.each_pair { |key, val|

      print_dt val, layer + 1, cur_num, :node_val => key

    }

  end

  def self.gen_graph root, path

    cout = open path, 'w'

    cout.puts 'digraph{'

    self.clear

    self.gen_nodes root, cout, 1

    self.clear

    self.gen_edges root, 0, cout, 1

    self.clear

    cout.puts '}'

    cout.close

  end

  def self.gen_nodes node, out, indent = 0, **oth_para

    cur_num = @@NODE_NUMBERING

    tag = {}

    if node.class_tag.nil?

      tag[:Attr_name] = node.attr_tag_name

    else

      tag[:Class] = node.class_tag

    end

    out.print "\t" * indent, cur_num, handle_label(tag), ';'

    out.puts

    @@NODE_NUMBERING += 1

    node.child_nodes.each_pair { |key, val|

      self.gen_nodes val, out, indent

    }

  end

  def self.handle_label **label_map

    if label_map.empty?
      return ''
    end

    ret_str = '[label="'

    label_map.each_pair { |key, val|

      ret_str += "(#{key}:#{val})"

    }

    ret_str += '"]'

    ret_str

  end

  def self.gen_edges node, parent_num, cout, indent = 0, **label_params

    cur_num = @@NODE_NUMBERING

    unless parent_num == 0

      cout.print "\t" * indent

      cout.puts "#{parent_num}->#{cur_num}#{handle_label label_params}"

    end

    @@NODE_NUMBERING += 1

    if node.child_nodes.empty?
      return
    end

    node.child_nodes.each_pair { |key, val|

      gen_edges val, cur_num, cout, indent, :val => key

    }

  end

end


if $0 == __FILE__

  Graphviz_DT_API.gen_graph nil, './test.dot'

end