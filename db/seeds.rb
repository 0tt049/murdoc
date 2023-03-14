def createChild(obj, parent = nil)
  unless obj.respond_to?(:name)
    return
  else
    if obj.name == "BasicObject"
      node = Node.create("name" => obj.name, "category" => obj.class.name.downcase)
    else
      node = parent.children.create("name" => obj.name, "category" => obj.class.name.downcase)
    end
  node.save
  node
  end
end

def procreate(obj, parent = nil)
  if (obj.respond_to?(:name) && obj.name.respond_to?(:to_sym)) && ALLOWED_CLASSES.include?(obj.name.to_sym)
      parent = createChild(obj, parent)
      children = parent.name.constantize.subclasses
      children.each { |child| procreate(child, parent) }
  end
end

def find_meth(node)
  begin
    name = node.name.constantize
  rescue NameError => e
    puts e
  ensure
    unless name.nil?
      inst_meth = name.instance_methods(false).sort!
      meth = name.methods(false).sort!
      inst_meth.each { |m| node.siblings.create("name" => m, "category" => "instance methods") }
      meth.each { |m| node.siblings.create("name" => m, "category" => "methods") }
    end
    node.descendants.each { |sub| find_meth(sub) }
  end
end


ALLOWED_CLASSES = [:Exception,
 :Fiber,
 :FiberError,
 :Thread,
 :Gem,
 :ErrorHighlight,
 :IO,
 :SystemExit,
 :Complex,
 :DidYouMean,
 :SignalException,
 :Interrupt,
 :StandardError,
 :TypeError,
 :ArgumentError,
 :IndexError,
 :KeyError,
 :Set,
 :Delegator,
 :RangeError,
 :ScriptError,
 :SyntaxError,
 :LoadError,
 :String,
 :Array,
 :NotImplementedError,
 :NilClass,
 :NameError,
 :NoMethodError,
 :RUBY_RELEASE_DATE,
 :RUBY_PLATFORM,
 :RuntimeError,
 :FrozenError,
 :SecurityError,
 :NoMemoryError,
 :EncodingError,
 :RUBY_REVISION,
 :NoMatchingPatternError,
 :NoMatchingPatternKeyError,
 :RUBY_ENGINE_VERSION,
 :SystemCallError,
 :Shellwords,
 :Errno,
 :Warning,
 :Etc,
 :ARGV,
 :Hash,
 :Time,
 :RUBY_COPYRIGHT,
 :RUBY_ENGINE,
 :Integer,
 :RUBY_DESCRIPTION,
 :FileUtils,
 :RUBY_PATCHLEVEL,
 :StringScanner,
 :Dir,
 :SimpleDelegator,
 :RUBY_VERSION,
 :TracePoint,
 :TrueClass,
 :FalseClass,
 :Encoding,
 :TOPLEVEL_BINDING,
 :ThreadGroup,
 :ThreadError,
 :Mutex,
 :RbConfig,
 :Rational,
 :Queue,
 :ClosedQueueError,
 :STDIN,
 :Comparable,
 :UncaughtThrowError,
 :STDERR,
 :Enumerable,
 :ConditionVariable,
 :SizedQueue,
 :STDOUT,
 :Random,
 :CodeRay,
 :Readline,
 :ScanError,
 :ARGF,
 :PP,
 :Signal,
 :FileTest,
 :File,
 :Monitor,
 :SortedSet,
 :Pry,
 :ZeroDivisionError,
 :FloatDomainError,
 :Numeric,
 :Proc,
 :MonitorMixin,
 :Forwardable,
 :LocalJumpError,
 :SystemStackError,
 :Method,
 :OpenStruct,
 :Process,
 :ENV,
 :Fixnum,
 :Float,
 :Struct,
 :RegexpError,
 :SingleForwardable,
 :UnboundMethod,
 :Binding,
 :Regexp,
 :Math,
 :Bignum,
 :MatchData,
 :StringIO,
 :GC,
 :PrettyPrint,
 :Pathname,
 :MethodSource,
 :ObjectSpace,
 :Tempfile,
 :Enumerator,
 :CROSS_COMPILING,
 :Marshal,
 :StopIteration,
 :Range,
 :Ractor,
 :Object,
 :BasicObject,
 :Class,
 :Module,
 :Kernel,
 :Refinement,
 :RubyVM,
 :IOError,
 :EOFError,
 :Symbol,
 :UnicodeNormalize,
 :RUBYGEMS_ACTIVATION_MONITOR]

procreate(BasicObject)
root = Node.find_by(id: 1)
find_meth(root)
