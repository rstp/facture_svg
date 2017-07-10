#test_timesutils
gem 'minitest'
require 'minitest/autorun'
require  'stprutil'

describe "Utilities" do
   include TimesUtil
   
   describe "time conversion" do
      it "converts hms to seconds" do
         hms2seconds("10:09:8").must_equal 36548
      end
      it "does not converts hms to seconds" do
         hms2seconds(":09:8").must_equal 0
      end
      it "converts seconds to h-min with rounddown" do
         sec2hour_min(1*3600+45*60+61).must_equal "01h 46m"
      end
      it "converts seconds to h-min without min roundup" do
         sec2hour_min(1*3600+45*60+29).must_equal "01h 45m"
      end
   end
end
