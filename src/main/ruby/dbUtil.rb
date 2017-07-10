#require 'yaml'
require 'activerecord-jdbch2-adapter'
require 'arjdbc'
require 'java'
require 'h2-1.3.163.jar'


## Open the database
#
# @param none
#
class DbUtil
  def initialize(props)
    @pprops = props["db"]
    openDB
  end
  
  def openDB
    driver = @pprops["class"]
    url = @pprops["url"]
    username = @pprops["uname"]
    password = @pprops["pass"]  
    dbconf = { 
       :adapter      => 'jdbch2',
       :driver       => driver,
       :url          => url,
       :username     => username,
       :password     => password
    }
    begin
      #        @logger.log("\tdb=#{@dbconf}") if @opts.debug
      ActiveRecord::Base.establish_connection(dbconf)
    rescue => e
      puts "Erreur: #{e}"
      exit 1
    end
  end #openDB

## locate client from invoice in bd and return client infos
#
# @param integer invno the invoice number
# @return [hash] or [null]  contains the client informations {nom, addr, ville, tele, facno}
#
  def findClient(invno)
    nv = nil
    begin
      clientno = Invoice.find(invno).clientid
      clientinfo =  Client.find(clientno)
      
      nv = {
        'nom'   => clientinfo.nom,
        'addr'  => "rue 123", #clientinfo.addresse,
        'ville' => clientinfo.addresse,
        'tele'  => "514 268 0793", #clientinfo.tele
        'facno'  => invno
      }  
    rescue => e
#      puts "error=table.find {#{e}}"
#     @logger.log("error=table.find {#{e}}")
    end
    return nv
  end

end # class DbUtil


# Class for the activerecord transaction table
class Invoice < ActiveRecord::Base
   self.table_name = "public.invoice"
end   
# Class for the activerecord update transaction table
class Client < ActiveRecord::Base
   self.table_name = "public.client"
end  
