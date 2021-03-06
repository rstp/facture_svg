# -*- encoding: utf-8 -*-
# stub: activerecord-jdbc-adapter 1.3.17 ruby lib

Gem::Specification.new do |s|
  s.name = "activerecord-jdbc-adapter".freeze
  s.version = "1.3.17"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nick Sieger, Ola Bini, Karol Bucek and JRuby contributors".freeze]
  s.date = "2015-06-30"
  s.description = "AR-JDBC is a database adapter for Rails' ActiveRecord component designed to be used with JRuby built upon Java's JDBC API for database access. Provides (ActiveRecord) built-in adapters: MySQL, PostgreSQL and SQLite3 as well as adapters for popular databases such as Oracle, SQLServer, DB2, FireBird and even Java (embed) databases: Derby, HSQLDB and H2. It allows to connect to virtually any JDBC-compliant database with your JRuby on Rails application.".freeze
  s.email = ["nick@nicksieger.com".freeze, "ola.bini@gmail.com".freeze, "self@kares.org".freeze]
  s.homepage = "https://github.com/jruby/activerecord-jdbc-adapter".freeze
  s.licenses = ["BSD".freeze]
  s.rdoc_options = ["--main".freeze, "README.md".freeze, "-SHN".freeze, "-f".freeze, "darkfish".freeze]
  s.rubyforge_project = "jruby-extras".freeze
  s.rubygems_version = "2.6.8".freeze
  s.summary = "JDBC adapter for ActiveRecord, for use within JRuby on Rails.".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>.freeze, [">= 2.2"])
    else
      s.add_dependency(%q<activerecord>.freeze, [">= 2.2"])
    end
  else
    s.add_dependency(%q<activerecord>.freeze, [">= 2.2"])
  end
end
