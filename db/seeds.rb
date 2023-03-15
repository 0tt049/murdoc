obj = "Class"
cat = "class"

parent = Node.create("name" => obj, "category" => cat)
parent.save
3.times do
  child = parent.children.create("name" => "Sub#{parent.name}", "category" => cat)
  child.save
end

children = Node.find_by(id: 1).children

children.each do |child|
  5.times do
    sibling = child.children.create("name" => "Sub#{child.name}", "category" => cat)
    sibling.save
  end
end

class_list_id = (2..9).to_a
4.times do
  my_id = class_list_id.sample
  sib_module = Node.find_by(id: my_id).siblings.create("name" => "Module#{my_id}", "category" => "module")
  sib_module.save
  class_list_id - [my_id]
end

Node.all.each do |n|
  5.times do
    meth = n.children.create("name" => "method_#{n.name.downcase}", "category" => "instance_method")
    meth.save
    meth = n.children.create("name" => "method_#{n.name.downcase}", "category" => "method")
    meth.save
  end
end
# def createChild(obj, parent = nil)
#   unless obj.respond_to?(:name)
#     return
#   else
#     if obj.name == "BasicObject"
#       node = Node.create("name" => obj.name, "category" => obj.class.name.downcase)
#     else
#       node = parent.children.create("name" => obj.name, "category" => obj.class.name.downcase)
#     end
#   node.save
#   node
#   end
# end

# def procreate(obj, parent = nil)
#   if (obj.respond_to?(:name) && obj.name.respond_to?(:to_sym)) && ALLOWED_CONSTANTS.include?(obj.name.to_sym)
#       parent = createChild(obj, parent)
#       children = parent.name.constantize.subclasses
#       children.each { |child| procreate(child, parent) }
#   end
# end

# def find_meth(node)
#   begin
#     name = node.name.constantize
#   rescue NameError => e
#   ensure
#     unless name.nil?
#       inst_meth = name.instance_methods(false).sort!
#       meth = name.methods(false).sort!
#       inst_meth.each { |m| node.siblings.create("name" => m, "category" => "instance methods") }
#       meth.each { |m| node.siblings.create("name" => m, "category" => "methods") }
#     end
#     node.descendants.each { |sub| find_meth(sub) }
#   end
# end

# def put_doc
#   i = 1
#   100.times do
#     node = Node.find_by(id: i)
#     node.documentation = LOREM
#     node.save
#     i += 1
#   end
# end

# LOREM = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed quis arcu luctus, gravida justo nec, molestie nibh. Sed rutrum tellus quis sem mollis, eget elementum mi tincidunt. Nunc sit amet enim id tortor cursus sodales. Etiam malesuada ligula in cursus mattis. Integer blandit nec nunc quis tempus. Nullam nec eros ut sem accumsan feugiat non vel nunc. Fusce dictum, nisl et pretium commodo, ipsum metus condimentum eros, sit amet dignissim nisi massa accumsan augue. Nullam vel molestie mi. Maecenas mollis diam eu ipsum rhoncus blandit quis at mauris. Sed et mauris molestie, luctus dui ac, congue nisi. Donec nec congue ipsum. Cras cursus orci tellus, ac suscipit turpis lacinia id. Donec id diam eget est cursus ultrices ac sit amet ante. Etiam diam sapien, feugiat at tristique vitae, ullamcorper sed purus. Aenean gravida eu nulla ac mattis."

# ALLOWED_CONSTANTS = [
#   :Abbrev,
#   :Addrinfo,
#   :ArgumentError,
#   :Array,
#   :Base64,
#   :BasicObject,
#   :BasicSocket,
#   :Benchmark,
#   :BigDecimal,
#   :BigMath,
#   :Binding,
#   :Bundler,
#   :CGI,
#   :CROSS_COMPILING,
#   :Class,
#   :ClosedQueueError,
#   :Comparable,
#   :Complex,
#   :ConditionVariable,
#   :Date,
#   :DateTime,
#   :Delegator,
#   :DidYouMean,
#   :Digest,
#   :Dir,
#   :EOFError,
#   :ERB,
#   :Encoding,
#   :EncodingError,
#   :Enumerable,
#   :Enumerator,
#   :Errno,
#   :ErrorHighlight,
#   :Etc,
#   :Exception,
#   :FalseClass,
#   :Fiber,
#   :FiberError,
#   :Fiddle,
#   :File,
#   :FileTest,
#   :FileUtils,
#   :Find,
#   :Float,
#   :FloatDomainError,
#   :Forwardable,
#   :FrozenError,
#   :GC,
#   :Gem,
#   :Hash,
#   :IO,
#   :IOError,
#   :IPAddr,
#   :IPSocket,
#   :IRB,
#   :IndexError,
#   :Integer,
#   :Interrupt,
#   :JSON,
#   :Kernel,
#   :KeyError,
#   :LoadError,
#   :LocalJumpError,
#   :Logger,
#   :Marshal,
#   :MatchData,
#   :Math,
#   :Method,
#   :Module,
#   :Monitor,
#   :MonitorMixin,
#   :Mutex,
#   :Mutex_m,
#   :NameError,
#   :Net,
#   :NilClass,
#   :NoMatchingPatternError,
#   :NoMatchingPatternKeyError,
#   :NoMemoryError,
#   :NoMethodError,
#   :NotImplementedError,
#   :Numeric,
#   :Object,
#   :ObjectSpace,
#   :OpenSSL,
#   :OpenStruct,
#   :OptParse,
#   :OptionParser,
#   :PP,
#   :ParseError,
#   :Pathname,
#   :PrettyPrint,
#   :Proc,
#   :Process,
#   :Psych,
#   :Queue,
#   :RDoc,
#   :Racc,
#   :Ractor,
#   :Rake,
#   :Random,
#   :Range,
#   :RangeError,
#   :Rational,
#   :RbConfig,
#   :Readline,
#   :Refinement,
#   :Regexp,
#   :RegexpError,
#   :Reline,
#   :Ripper,
#   :RubyLex,
#   :RubyVM,
#   :RuntimeError,
#   :ScanError,
#   :ScriptError,
#   :SecureRandom,
#   :SecurityError,
#   :Set,
#   :Shellwords,
#   :Signal,
#   :SignalException,
#   :SimpleDelegator,
#   :SingleForwardable,
#   :Singleton,
#   :SizedQueue,
#   :Socket,
#   :SocketError,
#   :StandardError,
#   :StopIteration,
#   :String,
#   :StringIO,
#   :StringScanner,
#   :Struct,
#   :Symbol,
#   :SyntaxError,
#   :SystemCallError,
#   :SystemExit,
#   :SystemStackError,
#   :TCPServer,
#   :TCPSocket,
#   :TSort,
#   :Tempfile,
#   :Thread,
#   :ThreadError,
#   :ThreadGroup,
#   :Time,
#   :Timeout,
#   :TracePoint,
#   :TrueClass,
#   :TypeError,
#   :UDPSocket,
#   :UNIXServer,
#   :UNIXSocket,
#   :URI,
#   :UnboundMethod,
#   :UncaughtThrowError,
#   :UnicodeNormalize,
#   :Warning,
#   :WeakRef,
#   :YAML,
#   :ZeroDivisionError,
#   :Zlib
# ]
# procreate(BasicObject)
# root = Node.find_by(id: 1)
# find_meth(root)
# put_doc
