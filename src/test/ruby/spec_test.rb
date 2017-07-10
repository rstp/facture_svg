
require 'minitest/autorun'
gem 'minitest'
require 'minitest/hooks/default'
require 'fileutils'
require 'fizzbuzz'

describe "FizzBuzz" do
    before (:all) do
        @fb = FizzBuzz.new
        @number = 15*rand(1..100) + 1

            testdir = File.dirname(__FILE__)
            # S1 = File.join(testdir, "stprutil1.yml")
            # S2 = File.join(testdir, "stprutil2.yml")
            FileUtils.cp  File.join(testdir, "stprutil1.yml"), File.join('/tmp', "stprutil1.yml")
            FileUtils.cp  File.join(testdir, "stprutil2.yml"), File.join('/tmp', "stprutil2.yml")
            if File.file?(File.join('/tmp', "stprutil1.yml"))
              puts "file exists to start"
            end
    end

    it "returns Fizz for multiples of 3" do
        @fb.print(3*@number).must_equal "Fizz"
    end

    it "returns Fizz for multiples of 5" do
        @fb.print(5*@number).must_equal "Buzz"
    end
    it "returns Fizz for multiples of 15" do
        @fb.print(15*@number).must_equal "FizzBuzz"
    end
end

# describe 'test pour 15' do
#   before do
#     File.delete  File.join('/tmp', "stprutil1.yml")
#   end
#   it 'file 2 was deleted' do
#     File.file?(File.join('/tmp', "stprutil2.yml")).must_be_nil
#   end
# end
