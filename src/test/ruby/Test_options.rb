#test_options

require 'minitest/autorun'
require  'options'
#require 'facture'

describe "options" do
      puts "\n\nTesting Program options..."

   # TODO help options exits program and aborts the test
   describe "help" do
      it "shows a help message" do
#         Util::Options.new(["-h"]).helpmessage.must_equal "help1"
      end
   end
   describe "initialization of facture" do
       before do
#           @fac = facture.new(2)
       end
       it "decode le no de facture" do
#            @fac.nofacture.must_equal 1
       end
   end

   describe "operating mode" do
       it "should not default to silent mode" do
            Options.new([]).silent.wont_equal true
        end
        it "sets silent  mode" do
            Options.new(["-s"]).silent.must_equal true
        end
   end

    describe "logfile" do
        it "returns a default log file" do
            Options.new().logfile.must_equal 'facture_svg.log'
        end
        it "defines the log file" do
            Options.new([ "-l" ,  "/home/test.log" ]).logfile.must_equal '/home/test.log'
        end
    end

    describe "autres arguments" do
        it "decode le no de facture" do
            Options.new([2]).nofacture.must_equal 2
        end

    end
end
