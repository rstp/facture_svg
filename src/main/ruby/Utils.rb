require 'yaml'

class Utils

  ## get the program properties for a system
  # if the props for that system contains a 'properties:' entry then
  # it is interpreted as the filename of the properties for that system
  # and it is loaded as the system's properties
  #
  # @param string yamlfile the file spec for the properties file
  # @param string program the program for which the properties are required
  # @return [hash]   contains the database properties  (:url, :uname, :pass, :class)
    def getprops(yamlfile,system)
       return nil unless File.file?(yamlfile)
       sysprop =   YAML.load_file  yamlfile
       # redirect to the system properties file if directed so.
       begin
          yamlfile = sysprop[system]['properties'] unless    ( sysprop[system].nil?  || sysprop[system]['properties'].nil?)
          return nil unless File.file?(yamlfile)
          sysprop = YAML.load_file yamlfile
       rescue => e
          puts e
          exit 1
       end

#       The program requires some configurations
        begin
           x = sysprop[system]["db"]
           return sysprop[system]
        rescue => e
          #     @logger.log("error=program requires configuration for #{system}")
           return nil
        end
  end #getprops
end

# class Logger
#    attr_reader :logf
#    # Setup logging to the logfile and optionnally verbose output to stdout
#    #
#    # @param logfile string the log filename
#    # @param verbose boolean the verbose flag
#    def initialize(logfile="ofx.log", verbose=true)
#       @verbose = verbose
#       begin
#          @logf=File.new(logfile, "a")
#       rescue => e
#          $stderr << "Cannot reach logfile #{logfile}.  Loging to <user home>/ofx.log\n"
#          @logf = File.new( File.join(ENV['HOME'], "ofx.log") )
#       end
#    end
#
#    # perform logging
#    # @param [String] message  the message to log
#    def log(message=nil)
#       if @verbose
#          $stdout <<  "#{message}\n"
#          $stdout.flush
#       end
#       @logf << "#{message}\n"
#       @logf.flush
#       end
#
#    def fatal(message = nil)
#       $stderr.puts "\nFatal error:#{message}..abort."
#       exit
#    end
#    def error(message = nil)
#       $stderr.puts "\nError:#{message}"
#    end
#
# end
#
