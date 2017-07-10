#test_properties
#gem 'minitest'
require 'minitest/autorun'
require 'minitest/hooks/default'
require 'fileutils'
require  'Utils'

describe "Properties Utilities" do
  before (:all) do
      testdir = File.dirname(__FILE__)
      s1 = File.join(testdir, "stprutil1.yml")
      s2 = File.join(testdir, "stprutil2.yml")
      FileUtils.cp  s1, File.join('/tmp', "stprutil1.yml")
      FileUtils.cp  s2, File.join('/tmp', "stprutil2.yml")
      @nonexistent_file = File.join('/tmp', "123454321.yml")
      begin
        File.delete File.join('/tmp', "123454321.yml")
      rescue => e
      end
      if File.file?(File.join('/tmp', "stprutil1.yml"))
        puts "test yml's installed"
      end
      @ut = Utils.new
      @Y1 = File.join('/tmp', "stprutil1.yml")
  end


      it "tries to loads a nonexistent yml file" do
         @ut.getprops(@nonexistent_file,'xx').must_be_nil
      end
      it "cannot find the system in the properties file" do
         @ut.getprops(@Y1,'aa').must_be_nil
      end
      it "finds a property in the initial property yml file" do
         @ut.getprops(@Y1,'xx')['zz'].must_equal "xyz"
      end
      it "finds a property in an indirect property yml file" do
         @ut.getprops(@Y1,'yy')['zz'].must_equal "zzz"
      end
end
