# -*- encoding: utf-8 -*-
# Ref: http://yehudakatz.com/2010/04/02/using-gemspecs-as-intended/

lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require_relative 'version'

Gem::Specification.new do |s|
  s.summary     = "Impression de factures"
  s.description = "voir README.adoc"
  s.authors     = ["Robert St-Pierre"]
  s.email       = ["rstp@dironec.com"]

  s.executables  = ['application_bootstrap', 'rake']
  s.files        = Dir.glob("{bin,lib,src/main}/**/*")  + %w(facture.svg log4j.properties version.rb LICENSE README.md ROADMAP.md CHANGELOG.md)

  s.name        = 'facture_svg'    #gem name
  s.version     = "#{VERSION}"
  s.platform    = Gem::Platform::CURRENT
  s.homepage    = "http://github.com/"

#  s.required_rubygems_version = ">= 1.3.6"
#  s.rubyforge_project         = "bundler"
#  s.add_runtime_dependency = ""
#  s.add_development_dependency "rspec"

  s.require_path = ['lib','src/main/ruby']
end
