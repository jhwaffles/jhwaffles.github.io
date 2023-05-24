# -*- encoding: utf-8 -*-
# stub: classifier 1.3.5 ruby lib

Gem::Specification.new do |s|
  s.name = "classifier".freeze
  s.version = "1.3.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Lucas Carlson".freeze]
  s.date = "2018-04-17"
  s.description = "A general classifier module to allow Bayesian and other types of classifications.".freeze
  s.email = "lucas@rufy.com".freeze
  s.homepage = "https://github.com/cardmagic/classifier".freeze
  s.licenses = ["LGPL".freeze]
  s.rubygems_version = "3.3.26".freeze
  s.summary = "A general classifier module to allow Bayesian and other types of classifications.".freeze

  s.installed_by_version = "3.3.26" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<fast-stemmer>.freeze, ["~> 1.0.0"])
    s.add_runtime_dependency(%q<mathn>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_development_dependency(%q<rdoc>.freeze, [">= 0"])
  else
    s.add_dependency(%q<fast-stemmer>.freeze, ["~> 1.0.0"])
    s.add_dependency(%q<mathn>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_dependency(%q<rdoc>.freeze, [">= 0"])
  end
end
