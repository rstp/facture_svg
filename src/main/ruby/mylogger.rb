
require 'logger'

class MyLogger
   @log = nil
   def initialize
#       $LOAD_PATH.each { |c| puts c}
       file = File.open('log2.log', 'a')
      @log = Logger.new(file)
#      @log.level = Logger::WARN
# will print something like this 
#    W, [2017-07-11T12:09:29.243266 #25635]  WARN -- robert: "message"
      original_formatter = Logger::Formatter.new
      @log.formatter = proc {|severity, datetime, progname, msg|
          original_formatter.call(severity, datetime, "robert", msg.dump)
      }
   end

   def logtest
     @log.debug("debug from jruby logger is a debug message")
     @log.info("info from jruby logger this is an info message")
     @log.warn("warning from jruby logger this is a warning message")
     @log.close

   end
end
