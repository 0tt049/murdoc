def procreate(obj, parent = nil, depth = 0)
  if MY_LIST.any? { |prefix| obj.to_s.start_with?(prefix) }
    name = klass.name.split("::").last
    parent = print_family(klass, name, "", false, nil, depth)
    children = klass.subclasses
    children.each { |child| procreate(child, parent, depth + 1) }
  else
    "END"
  end
end

def print_family(klass, name, prefix = '', is_last_child = false)
  # Create a yellow line with the correct prefix
  line = "#{prefix}#{is_last_child ? '└─ ' : '├─ '}".colorize(:yellow)

  # Add the class name in blue and bold
  line += "#{name.colorize(:blue).bold}"

  # Print the line
  puts line

  # Check if the class has any subclasses
  subclasses = klass.subclasses
  return if subclasses.empty?

  # Get the prefix for the subclasses
  new_prefix = "#{prefix}#{is_last_child ? '   ' : '│  '}"

  # Recursively print the subclasses
  last_index = subclasses.length - 1
  subclasses.each_with_index do |subclass, index|
    is_last = (index == last_index)
    subclass_name = subclass.name.split("::").last
    print_family(subclass, subclass_name, new_prefix, is_last)
  end
end

procreate(BasicObject)
