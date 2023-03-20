def make_children(parent)
  begin
    children = parent.name.constantize.subclasses
  rescue NameError
  ensure
    return if children.nil?
    children.filter! { |child| child.name.respond_to?(:gsub) }
    children.filter! { |child| ALLOWED_CONSTANTS.include?(child.name.gsub(/(?=::).+/, "")) }
    children.each  do |child|
    baby = parent.children.create("name" => child.name, "category" => "class")
    baby.save
    end
  end
end

def procreate(depth)
  return if Node.at_depth(depth).empty?
  Node.at_depth(depth).map { |node| make_children(node) }
  procreate(depth + 1)
end

def make_modules
  included_methods = []
  Node.all.each do |node|
    begin
      mod_arr = node.name.constantize.included_modules
    rescue
    ensure
      return if mod_arr.nil?
      mod_arr.filter! { |mod| mod.name.respond_to?(:gsub) }
      mod_arr.filter! { |mod| ALLOWED_CONSTANTS.include?(mod.name.gsub(/(?=::).+/, "")) }
      mod_arr.filter! { |mod| !included_methods.include?(mod.name) }
      mod_arr.each do |mod|
        brother = node.siblings.create("name" => mod.name, "category" => "module")
        brother.save
        included_methods << brother.name
    end
    end
  end
end

def make_methods
  Node.all.each do |obj|
    begin
      inst_meth_arr = obj.name.constantize.instance_methods(false)
    rescue NameError
    ensure
      if inst_meth_arr.respond_to?(:empty?) && !inst_meth_arr.empty?
        inst_meth_arr.each do |imet|
            child = obj.children.create("name" => imet.name, "category" => "instance_method")
            child.save
        end
      end
    end
    begin
      meth_arr = obj.name.constantize.methods(false)
    rescue NameError
    ensure
      if meth_arr.respond_to?(:empty?) && !meth_arr.empty?
        inst_meth_arr.each do |met|
            child = obj.children.create("name" => met.name, "category" => "method")
            child.save
        end
      end
    end
  end
end

def make_doc
  node_arr = Node.all
  node_arr.each do |node|
    if node.category == "class" || node.category == "module"
      node.documentation = %x|ri -fmarkdown #{node.name}|
      node.save
    else
      parent = node.parent.name
      name_esc = node.name.gsub(/(?=[\]\[|*?'"`><])/, '\\')
      node.documentation = %x|ri -fmarkdown #{parent}.#{name_esc}|
      node.save
    end
  end
end

def complete_doc
  node_arr = Node.all
  node_arr.each do |node|
    if node.documentation == ""
      node.documentation = MISSING_DOC
      node.save
    end
  end
end

ALLOWED_CONSTANTS = [
  "Abbrev",
  "Addrinfo",
  "ArgumentError",
  "Array",
  "Base64",
  "BasicObject",
  "BasicSocket",
  "Benchmark",
  "BigDecimal",
  "BigMath",
  "Binding",
  "Bundler",
  "CGI",
  "Class",
  "ClosedQueueError",
  "Comparable",
  "Complex",
  "ConditionVariable",
  "Date",
  "DateTime",
  "Delegator",
  "DidYouMean",
  "Digest",
  "Dir",
  "EOFError",
  "ERB",
  "Encoding",
  "EncodingError",
  "Enumerable",
  "Enumerator",
  "Errno",
  "ErrorHighlight",
  "Etc",
  "Exception",
  "FalseClass",
  "Fiber",
  "FiberError",
  "Fiddle",
  "File",
  "FileTest",
  "FileUtils",
  "Find",
  "Float",
  "FloatDomainError",
  "Forwardable",
  "FrozenError",
  "GC",
  "Gem",
  "Hash",
  "IO",
  "IOError",
  "IPAddr",
  "IPSocket",
  "IRB",
  "IndexError",
  "Integer",
  "Interrupt",
  "JSON",
  "Kernel",
  "KeyError",
  "LoadError",
  "LocalJumpError",
  "Logger",
  "Marshal",
  "MatchData",
  "Math",
  "Method",
  "Module",
  "Monitor",
  "MonitorMixin",
  "Mutex",
  "NameError",
  "Net",
  "NilClass",
  "NoMatchingPatternError",
  "NoMatchingPatternKeyError",
  "NoMemoryError",
  "NoMethodError",
  "NotImplementedError",
  "Numeric",
  "Object",
  "ObjectSpace",
  "OpenSSL",
  "OpenStruct",
  "OptParse",
  "OptionParser",
  "PP",
  "ParseError",
  "Pathname",
  "PrettyPrint",
  "Proc",
  "Process",
  "Psych",
  "Queue",
  "RDoc",
  "Racc",
  "Ractor",
  "Rake",
  "Random",
  "Range",
  "RangeError",
  "Rational",
  "RbConfig",
  "Readline",
  "Refinement",
  "Regexp",
  "RegexpError",
  "Reline",
  "Ripper",
  "RubyLex",
  "RubyVM",
  "RuntimeError",
  "ScanError",
  "ScriptError",
  "SecureRandom",
  "SecurityError",
  "Set",
  "Shellwords",
  "Signal",
  "SignalException",
  "SimpleDelegator",
  "SingleForwardable",
  "Singleton",
  "SizedQueue",
  "Socket",
  "SocketError",
  "StandardError",
  "StopIteration",
  "String",
  "StringIO",
  "StringScanner",
  "Struct",
  "Symbol",
  "SyntaxError",
  "SystemCallError",
  "SystemExit",
  "SystemStackError",
  "TCPServer",
  "TCPSocket",
  "TSort",
  "Tempfile",
  "Thread",
  "ThreadError",
  "ThreadGroup",
  "Time",
  "Timeout",
  "TracePoint",
  "TrueClass",
  "TypeError",
  "UDPSocket",
  "UNIXServer",
  "UNIXSocket",
  "URI",
  "UnboundMethod",
  "UncaughtThrowError",
  "UnicodeNormalize",
  "Warning",
  "WeakRef",
  "YAML",
  "ZeroDivisionError",
  "Zlib"
]

MISSING_DOC = "# Missing Documentation\n\nUnfortunatly this Item is lacking documentation.\nIf you would like to help the **Ruby** Language Community on\nit's documentation effort, please go to [Documentation Guide](https://docs.ruby-lang.org/en/master/contributing/documentation_guide_md.html)."

root = Node.create("name" => BasicObject.name, "category" => "class")
procreate(root.depth)
make_modules
make_methods
make_doc
complete_doc
