root = Node.find_by(name: "BasicObject") # This string sets the start of the iteration

def print_tree(node, prefix = "", is_last_child = false)
  if is_last_child
    new_prefix = prefix + "└─ ".colorize(:yellow)
    new_prefix_sub = prefix + "   ".colorize(:yellow)
  else
    new_prefix = prefix + "├─ ".colorize(:yellow)
    new_prefix_sub = prefix + "│  ".colorize(:yellow)
  end

  name = "#{node.name} (#{node.category})"
  if node.category == "class"
    name = name.colorize(:blue).bold
  elsif node.category == "module"
    name = name.colorize(:magenta).bold
  end
  puts new_prefix + name

  prefix_sub = prefix + (is_last_child ? "   " : "│  ")
  node.children.each_with_index do |child, i|
    print_tree(child, prefix_sub, i == node.children.size - 1)
  end

  if node.name.constantize.respond_to?(:instance_methods)
    methods = node.name.constantize.instance_methods(false).sort
    methods.each do |method|
      puts new_prefix_sub + "└─ " + "##{method}".colorize(:cyan) + " (instance_method)".colorize(:light_black)
    end
  end
end
