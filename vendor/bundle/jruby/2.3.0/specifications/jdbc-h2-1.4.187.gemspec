# -*- encoding: utf-8 -*-
# stub: jdbc-h2 1.4.187 ruby lib

Gem::Specification.new do |s|
  s.name = "jdbc-h2".freeze
  s.version = "1.4.187"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nick Sieger, Ola Bini, Karol Bucek and JRuby contributors".freeze]
  s.date = "2015-04-24"
  s.description = "Install this gem `require 'jdbc/h2'` and invoke `Jdbc::H2.load_driver` within JRuby to load the driver.".freeze
  s.email = ["nick@nicksieger.com".freeze, "ola.bini@gmail.com".freeze, "self@kares.org".freeze]
  s.homepage = "http://github.com/jruby/activerecord-jdbc-adapter/tree/master/jdbc-hsqldb".freeze
  s.licenses = ["H2".freeze]
  s.rdoc_options = ["--main".freeze, "README.md".freeze]
  s.rubygems_version = "2.6.8".freeze
  s.summary = "H2 (JDBC driver) for JRuby (usable with ActiveRecord-JDBC).".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version
end
