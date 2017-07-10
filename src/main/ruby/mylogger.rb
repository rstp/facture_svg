
require 'java'
require 'log4j-api-2.8.2.jar'
require 'log4j-core-2.8.2.jar'
require 'log4jruby'

class MyLogger
   @log = nil
   def initialize
      @log = Log4jruby::Logger.get(self.class.name, :tracing => true, :level => :debug)
   end
   
   def logtest
     @log.debug("logging from jruby is a debug message")
     @log.info("Hello this is an info message")
   end
end

log = MyLogger.new
log.logtest
