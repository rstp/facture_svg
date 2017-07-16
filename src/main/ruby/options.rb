require 'optparse'

#module Util
   class Options
      attr_reader :logfile
      attr_reader :silent
      attr_reader :nofacture
      attr_reader :fich_gabarit

      def initialize(argv = [])
         @silent = false
         @logfile = "facture_svg.log"
         @fich_gabarit = "facture.svg"
         parse(argv)

         # what's left after the options
         @nofacture = argv[0]   # only the first argument
      end
private
      def parse(argv)
         OptionParser.new do |opts|
#            opts.banner = "Usage: facture [ options ] [ dirs to backup use -x option for list]"
            opts.banner = "Usage: facture [ options ] "

#            opts.on("--version", "print the gem version") do
#               $stdout << "Version = #{GEMSPEC}\n"
#               exit 0
#            end
#            opts.on("-y", "how to restore a backup") do
#               $stdout << RECOVERY
#               exit 0
#            end
            opts.on("-g", "--gabarit fichier_gabarit",  "The svg gabarit file") do |fn|
               @fich_gabarit = fn
            end
#            opts.on("-d", "debug mode on (no run)") do
#               @debug = true
#            end
#            opts.on("-i", "display configuration details then exit") do
#               @info = true
#            end
            opts.on("-l", "--logfile logfilename", "the file logs are written to") do |fn|
               @logfile = fn
            end
            opts.on("-s", "--silent", "messages & logs will not be sent to the terminal") do
               @silent = true
            end
            opts.on("-h", "--help", "Show this help message") do
               puts opts
               exit
            end
            begin
 #              argv = ["-h"] if argv.empty?
               opts.parse!(argv)
            rescue OptionParser::ParseError => e
               STDERR.puts e.message, "\n", opts
            end
         end
      end
   end   # class
#end  # module
