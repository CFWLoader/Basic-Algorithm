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

    node.child_nodes.each_pair {|key, val|

      print_dt val, layer + 1, cur_num, :node_val => key

    }

  end

  def self.gen_graph root, path

    cout = open path, 'w'

    cout.puts 'digraph{'

    self.clear

    self.gen_nodes root, cout, 1

    self.gen_edges root, cout, 1

    self.clear

    cout.puts '}'

    cout.close

  end

  def self.gen_nodes root, out, indent = 0

    cur_num = @@NODE_NUMBERING

    if node.class_tag.nil?

      print "(#{cur_num}, #{node.attr_tag_name}, #{node.child_nodes.keys.inspect}, #{parent_num}, #{oth_para[:node_val]})\n"

    else

      print "(#{cur_num}, #{node.class_tag}, #{parent_num}, #{oth_para[:node_val]})\n"

    end

    @@NODE_NUMBERING += 1

    node.child_nodes.each_pair {|key, val|

      self.gen_nodes root, out, indent

    }

  end

  def self.gen_edges root, cout, indent = 0

  end

end


if $0 == __FILE__

  Graphviz_DT_API.gen_graph nil, './test.dot'

end