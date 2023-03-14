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
  if (obj.respond_to?(:name) && obj.name.respond_to?(:to_sym)) && ALLOWED_CONSTANTS.include?(obj.name.to_sym)
      parent = createChild(obj, parent)
      children = parent.name.constantize.subclasses
      children.each { |child| procreate(child, parent) }
  end
end

def find_meth(node)
  begin
    name = node.name.constantize
  rescue NameError => e
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

ALLOWED_CONSTANTS = [
  :Abbrev,
  :Addrinfo,
  :ArgumentError,
  :Array,
  :Base64,
  :BasicObject,
  :BasicSocket,
  :Benchmark,
  :BigDecimal,
  :BigMath,
  :Binding,
  :Bundler,
  :CGI,
  :CROSS_COMPILING,
  :Class,
  :ClosedQueueError,
  :Comparable,
  :Complex,
  :ConditionVariable,
  :Date,
  :DateTime,
  :Delegator,
  :DidYouMean,
  :Digest,
  :Dir,
  :EOFError,
  :ERB,
  :Encoding,
  :EncodingError,
  :Enumerable,
  :Enumerator,
  :Errno,
  :ErrorHighlight,
  :Etc,
  :Exception,
  :FalseClass,
  :Fiber,
  :FiberError,
  :Fiddle,
  :File,
  :FileTest,
  :FileUtils,
  :Find,
  :Float,
  :FloatDomainError,
  :Forwardable,
  :FrozenError,
  :GC,
  :Gem,
  :Hash,
  :IO,
  :IOError,
  :IPAddr,
  :IPSocket,
  :IRB,
  :IndexError,
  :Integer,
  :Interrupt,
  :JSON,
  :Kernel,
  :KeyError,
  :LoadError,
  :LocalJumpError,
  :Logger,
  :Marshal,
  :MatchData,
  :Math,
  :Method,
  :Module,
  :Monitor,
  :MonitorMixin,
  :Mutex,
  :Mutex_m,
  :NameError,
  :Net,
  :NilClass,
  :NoMatchingPatternError,
  :NoMatchingPatternKeyError,
  :NoMemoryError,
  :NoMethodError,
  :NotImplementedError,
  :Numeric,
  :Object,
  :ObjectSpace,
  :OpenSSL,
  :OpenStruct,
  :OptParse,
  :OptionParser,
  :PP,
  :ParseError,
  :Pathname,
  :PrettyPrint,
  :Proc,
  :Process,
  :Psych,
  :Queue,
  :RDoc,
  :Racc,
  :Ractor,
  :Rake,
  :Random,
  :Range,
  :RangeError,
  :Rational,
  :RbConfig,
  :Readline,
  :Refinement,
  :Regexp,
  :RegexpError,
  :Reline,
  :Ripper,
  :RubyLex,
  :RubyVM,
  :RuntimeError,
  :ScanError,
  :ScriptError,
  :SecureRandom,
  :SecurityError,
  :Set,
  :Shellwords,
  :Signal,
  :SignalException,
  :SimpleDelegator,
  :SingleForwardable,
  :Singleton,
  :SizedQueue,
  :Socket,
  :SocketError,
  :StandardError,
  :StopIteration,
  :String,
  :StringIO,
  :StringScanner,
  :Struct,
  :Symbol,
  :SyntaxError,
  :SystemCallError,
  :SystemExit,
  :SystemStackError,
  :TCPServer,
  :TCPSocket,
  :TSort,
  :Tempfile,
  :Thread,
  :ThreadError,
  :ThreadGroup,
  :Time,
  :Timeout,
  :TracePoint,
  :TrueClass,
  :TypeError,
  :UDPSocket,
  :UNIXServer,
  :UNIXSocket,
  :URI,
  :UnboundMethod,
  :UncaughtThrowError,
  :UnicodeNormalize,
  :Warning,
  :WeakRef,
  :YAML,
  :ZeroDivisionError,
  :Zlib
]
procreate(BasicObject)
root = Node.find_by(id: 1)
find_meth(root)
