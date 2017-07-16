require 'rubygems'
require 'rest-client'
require 'json'
require 'open-uri'


## Class to manage an OrientDB database
#
# 
#attr_reader clientno, invoiceno, clientinfo

class ProjDBUtil
   def initialize
      @prot = "http://"
      @host = "airstp:2480"
      @user = 'admin'
      @pwd = 'admin'
      @url = "#{@prot}#{@host}"
      @urlp = "#{@prot}#{@user}:#{@pwd}@#{@host}"
   end

   ## function query REST
   #
   # @param sql query
   # @return HTTP response
   
   def  getREST(sql)
      ssql ="#{@urlp}/#{sql}"
      response = RestClient.get(URI::encode(ssql))
   end
   
   #function gets the client for an invoice
   #
   # @param no integer invoice number
   # @return client number as an integer or nil
   # @TODO query the invoice table instead of the projet table
   
   def getClientForInvoice(no)
      begin
         response = getREST("query/projets/sql/select PID,CLIENTID from projet")
         unless (response.code == 200)  #,params)
            return nil
         end
         unless (r = JSON.parse(response.body)["result"].find {|x| x["PID"]==no}["CLIENTID"])
            return nil
         end
         r
       rescue => e
         puts e
         return nil
      end
  end


   #function gets the client info
   #
   # @param invno integer client number
   # @return client info hash {:no, :nom, :addresse, :tele, } or nil
   
   def getClientInfo(no)
      sql = "query/projets/sql/select CID,nom,addresse,tele from client where CID='#{no}'"
      begin
         response = getREST(sql)
         unless (response.code == 200)  #,params)
            return nil
         end
         r = JSON.parse(response.body)["result"][0]
         x = {
            :nom => r["nom"],
            :addresse => r["addresse"] || "noaddr",
            :tele => r["tele"] || "000"
            }
            x
       rescue => e
         puts e
         return nil
      end
  end
end 
#class FindClientInfo

#a = ProjDBUtil.new
#[3,8,9].each { |no| 
#   puts "infoclient for projet no #{no}="
#   puts  a.getClientInfo(a.getClientForInvoice(no))
#}
#params = {
#   "command" => "select nom,cid from Client;"
#   ,
#   "parameters"=> []
#}

#sql = "#{urlp}/query/projets/sql/select nom,CID from Client"
#puts "Q=#{sql}\n========="
#rsp = nil
#begin
#   response = RestClient.get(URI::encode(sql))   #,params)
#   puts "response=#{response.code}"
#   rsp = JSON.parse(response.body)
#   puts "body\n=====#{rsp['result']}\n====="
#rescue => e
#   puts e
#   exit 1
#end
#rsp["result"].each {|x|
#      puts "nom=" + x["nom"] + "\t\tid=" + x["CID"].to_s
#} 
#p rsp["result"].map {|x| [x["nom"],x["CID"]]}
#p "CID=3 nom=" + rsp["result"].find {|x| x["CID"]==3}["nom"]