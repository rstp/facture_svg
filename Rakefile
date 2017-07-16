
#$LOAD_PATH.unshift ".lib"
ANT_HOME             = '/usr/local/ant'
@project_name        = 'ProjetStp'
@lib_dir             = 'lib'
# Ruby stuff
@ruby_script_dir     = 'src/main/ruby'
@ruby_test_dir       = 'src/test/ruby'
@ruby_bin_dir        = 'bin'


# Java stuff
@mainclass           = 'org.stp.Utils.log4jExample'
@java_src_dir        = 'src/main/java'
@java_build_dir      = 'build'
@classes_dir         = "#{@java_build_dir}" #/classes"
@jar_file            = "#{@lib_dir}/#{@project_name}.jar"
@test_jar_file       = "#{@java_build_dir}/#{@project_name}Test.jar"
@java_test_dir       = 'src/test/java'
@test_report_dir     = 'build/report'
@test_report_html    = 'build/report/html'

JRUBY_COMPLETE = "vendor/jruby-complete-9.1.12.0.jar"
jars = FileList["#{@lib_dir}/**/*.jar"].join(':')
GEM_PATH="vendor/bundle/jruby/2.3.0"
#JRUBY = "java -classpath .:#{JRUBY_COMPLETE} org.jruby.Main "
LOCALGEMS = "GEM_HOME=#{GEM_PATH} GEM_PATH=#{GEM_PATH} "
JRUBY = "/usr/local/jruby/bin/jruby --ng "

# ----- Ant-based tasks
require 'ant'
namespace :ant do
    lib_dir         = @lib_dir
    classes_dir     = @classes_dir
    java_src_dir    = @java_src_dir
    java_test_dir   = @java_test_dir
    jar_file        = @jar_file
    java_test_dir   = @java_test_dir
    test_report_dir = @test_report_dir

   desc "Compile the code using Ant"
   task :compileall => "clean" do
      ant.mkdir :dir => classes_dir
      compile(@java_src_dir)
      compile(@java_test_dir)
   end

  def compile(src)
    puts "Compiling java from #{src} to #{@classes_dir}"
    ant.javac :srcdir => src , :destdir => @classes_dir do
      classpath do
          fileset :dir => @lib_dir, :includes => "**/*.jar"
      end
    end
  end

   desc "Create a jar file of the compiled code using Ant"
   task :jar => "ant:compileall" do
      puts "Creating #{jar_file}"
      ant.delete :file => jar_file #, :verbose => true
      ant.jar :destfile => jar_file, :basedir => classes_dir
   end

  task :java_test => "ant:compileall" do
     puts "begin_tests"

      ant.mkdir :dir => test_report_dir

      ant.junit :fork => "yes", :forkmode => "once", :printsummary => "yes",
       :haltonfailure => "no", :failureproperty => "tests.failed" do
          classpath do
             fileset :dir => lib_dir, :includes => "**/*.jar"
             pathelement :location => classes_dir
          end
         formatter :type => "xml"
         batchtest :todir => test_report_dir do
            fileset :dir => java_test_dir, :includes => '**/*Test.java'
         end
      end

      if ant.project.getProperty("tests.failed")
          report
          puts "FAILURE: One or more tests failed. \nPlease check the test report in <<#{test_report_html}>>  for more info."
      end
      puts "end tests"
   end

   def report
         ant.junitreport :todir => test_report_dir do
            fileset :dir => test_report_dir, :includes => "TEST-*.xml"
            report :format => "frames", :todir => test_report_html
         end
   end


    #task :make_war => :make_jars do
    #  ant.mkdir :dir => DIST_DIR
    #  ant.war :warfile => "#{DIST_DIR}/#{PROJECT_NAME}.war", :webxml => "src/main/webapp/WEB-INF/web.xml" do
    #    fileset :dir => "src/main/webapp", :excludes => "**/web.xml"
    #    lib :dir => COMPILE_DIR, :excludes => "*-tests.jar"
    #    classes :dir => "src/main/resources"
    #    lib :dir => RUNTIME_LIB_DIR
    #  end
    #  puts
    #end
    #
    #task :run_jetty => [:clean, :make_jars] do
    #  ant.java :classname => "example.jetty.WebServer", :fork => 'yes', :failonerror => 'yes' do
    #    classpath :location => "src/main/resources"
    #    classpath :refid => "classpath"
    #  end
    #end
end

# ------ Project setup
namespace :setup do
   desc "1-Install bundler"
   task :bundler do
      sh %!#{JRUBY} -S gem install -i vendor/gem_home --no-rdoc --no-ri bundler!
   end

   desc "2-Install the gems"
   task :gems do
      sh %!#{JRUBY} -S bundle install --path=vendor/bundle --binstubs !
   end

   desc "3-Package gems"
   task :pack do
      sh %!#{LOCALGEMS} #{JRUBY} -S bundle package!
   end
end #setup


# ------ Ruby testing all files *_Test.rb
require 'rake/testtask'
Rake::TestTask.new do |task|
  task.libs << [@ruby_script_dir, @lib_dir]
  task.test_files = FileList["#{@ruby_test_dir}/Test_*.rb"]
  task.verbose = false
end

# ----- Ruby tasks
namespace :ruby do
   task :run do

     arg =  "#{@ruby_bin_dir}/application_bootstrap"
     libs = "#{@ruby_script_dir}:#{@ruby_bin_dir}:#{@lib_dir}"
     JRUBY_OPTS = "-I #{libs} #{arg}"
#     sh %!#{JRUBY} --help!
      sh %!#{LOCALGEMS} #{JRUBY} -I #{libs} #{arg} 8!
   end


end

# ----- Rake tasks
task :report => ["ant:report"]

task :run_jar  do
   jars = FileList["#{@lib_dir}/**/*.jar"].join(':')
   sh "java -classpath #{jars}:#{@jar_file} #{@mainclass}"
end

task :java_test => ["ant:java_test"]

task :run_mainclass => ["ant:compileall"] do
  jars = FileList["#{@lib_dir}/**/*.jar"].join(':')
  sh "java -classpath .:#{jars}:#{@java_build_dir} #{@mainclass}"

end
# Clean
require 'rake/clean'
    CLEAN << @java_build_dir

task :default => "ruby:run"
