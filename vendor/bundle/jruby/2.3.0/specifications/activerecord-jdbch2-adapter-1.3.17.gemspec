# -*- encoding: utf-8 -*-
# stub: activerecord-jdbch2-adapter 1.3.17 ruby lib

Gem::Specification.new do |s|
  s.name = "activerecord-jdbch2-adapter".freeze
  s.version = "1.3.17"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nick Sieger, Ola Bini, Karol Bucek and JRuby contributors".freeze]
  s.date = "2015-06-30"
  s.email = ["nick@nicksieger.com".freeze, "ola.bini@gmail.com".freeze, "self@kares.org".freeze]
  s.homepage = "https://github.com/jruby/activerecord-jdbc-adapter".freeze
  s.licenses = ["BSD".freeze]
  s.rubyforge_project = "jruby-extras".freeze
  s.rubygems_version = "2.6.8".freeze
  s.summary = "H2 JDBC adapter for JRuby on Rails.".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord-jdbc-adapter>.freeze, ["~> 1.3.17"])
      s.add_runtime_dependency(%q<jdbc-h2>.freeze, ["~> 1.3"])
    else
      s.add_dependency(%q<activerecord-jdbc-adapter>.freeze, ["~> 1.3.17"])
      s.add_dependency(%q<jdbc-h2>.freeze, ["~> 1.3"])
    end
  else
    s.add_dependency(%q<activerecord-jdbc-adapter>.freeze, ["~> 1.3.17"])
    s.add_dependency(%q<jdbc-h2>.freeze, ["~> 1.3"])
  end
end
