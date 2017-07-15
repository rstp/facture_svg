#!/usr/bin/env jruby
# -*- coding: UTF-8 -*-
#
# == modifs d'un fichier facture de type svg
#
#
# ============================================
# R1.0   2017-04-08 R.St-Pierre

require 'nokogiri'
require_relative 'dbUtil'
require_relative 'Utils'
require_relative 'options'
require_relative 'myloger'

## Classe pour gérer une facture
#
# La classe fait lit un gabarit (document svg), obtient les informations du client dans
# la base de données puis génère un nouveau document svg avec les informations.
#
class Facture

 def initialize(argv)
    @options=Options.new(argv)
    @logger=MyLogger.new(@ptions.logfile)
    @utils = Utils.new
    @system = "projets"
    @pprops = @utils.getprops(File.join(ENV['HOME'] , 'stp.yml'), @system)
    imprimeFacture(@options.nofacture)
 end

 # Fonction pour modifier certains champs d'un document svg
  #
  # @param svg  xmldocument  le document svg de la facture ou gabarit
  # @param nv [hash] contains the client informations {nom, addr, ville, tele, facno}
  # @return status nil=ok -1=notok see log
  #
  def modifDoc ( fac , nv)
    @fac = fac
    begin

#      @ns = fac.collect_namespaces # nice to know

# xpath location of info placeholder
      nomClient   = @fac.at_xpath('//svg:text[@id="nomClient"]')
      addrClient  = @fac.at_xpath('//svg:text[@id="addrClient"]')
      villeClient = @fac.at_xpath('//svg:text[@id="villeClient"]')
      teleClient  = @fac.at_xpath('//svg:text[@id="teleClient"]')
      facNo       = @fac.at_xpath('//svg:text[@id="facNo"]')

# Replace info
    nomClient.content = nv['nom']
    addrClient.content = nv['addr']
    villeClient.content = nv['ville']
    teleClient.content = nv['tele']
    facNo.content = nv['facno']

# Return modified document
      @fac
    rescue => e1
      puts e1
      nil
    end
  end

  ## Function affiche les details client de la chaine xml
  #
  # @param fac xmlstring la chaine xml
  # @return none
  #
  def shoClient( fac)
    puts fac.at_xpath('//svg:text[@id="nomClient"]').inner_text
    puts fac.at_xpath('//svg:text[@id="addrClient"]').inner_text
    puts fac.at_xpath('//svg:text[@id="villeClient"]').inner_text
    puts fac.at_xpath('//svg:text[@id="teleClient"]').inner_text
    puts fac.at_xpath('//svg:text[@id="facNo"]').inner_text
  end

  ## Lecture du gabarit
  #
  # @param string fich le nom du fichier svg du gabarit
  # @return xmldocument une chaine xml contenant le gabarit ou nil
  #
  def lireGabarit(fich)
    begin
      return doc = Nokogiri::XML( File.open( fich))
    rescue => e
      return nil
    end
  end

  ## Recherche les informations du client correspondant à une facture
  #
  # @param integer no le numéro de la facture
  # @return [hash] nil ou les informations du client {nom, addr, ville, tele, facno}
  #
  def getBDClient(no)
    db = DbUtil.new(@pprops)
    clientinfo = db.findClient(no)
  end

  ## Imprime une nouvelle facture
  #
  # @param integer no le numero de la facture
  # @return fichier nouvelle facture f<no>.svg
  #
  def imprimeFacture(no)
    fich_gabarit = "facture.svg"
    facno = no
    fich_nouvelle_facture = "f#{facno}.svg"

    # lecture du gabarit
    unless gabarit = lireGabarit(fich_gabarit)
       @logger.fatal("Problème avec la lecture du gabarit: #{e}")
       return nil
    end
    # créer une nouvelle facture à partir du gabarit

    # lire les paramètres du client dans la bd
    unless infoclient = getBDClient(facno)
      @logger.info "La facture #{facno} n'est pas enregistrée"
      exit 1
    end

    # modifier la nouvelle facture avec les infos de la bd
    newdoc = modifDoc(gabarit, infoclient)

    # Écrire la nouvelle facture
    File.open(fich_nouvelle_facture, 'w') { |f|
      f.print(newdoc)
      f.close
    }
    @logger.info "facture #{fich_nouvelle_facture} est imprimée"
  end

end # class Facture
#
# fac = Facture.new
#
# [1,2,3,4].each {|no|
#   fac.imprimeFacture(no)
# }
