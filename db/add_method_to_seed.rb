root = Node.find_by(id: 1)

def find_meth(node)
  name = node.name.constantize
  inst_meth = name.instance_methods(false).sort!
  meth = name.methods(false).sort!
  inst_meth.each { |m| node.siblings.create("name" => m, "category" => "instance methods") }
  meth.each { |m| node.siblings.create("name" => m, "category" => "methods") }
  node.descendants.each { |sub| find_meth(sub) }
end

find_meth(root)
