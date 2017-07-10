#test_properties
gem 'minitest'
require 'minitest/autorun'
require  'Utils'
require_relative 'setuptest.rb'

describe "Properties Utilities" do
   ut = Utils.new
   Y1 = File.join('/tmp', "stprutil1.yml")

      it "tries to loads a nonexistent yml file" do
         ut.getprops("/tmp/t.yml",'xx').must_be_nil
      end
      it "cannot find the system in the properties file" do
         ut.getprops(Y1,'aa')['aa'].must_be_nil
      end
      it "loads an indirect property yml file" do
         ut.getprops(Y1,'yy')['yy']['zz'].must_equal "zzz"
      end
      it "loads a property yml file" do
         ut.getprops(Y1,'xx')['xx']['zz'].must_equal "xyz"
      end
end
