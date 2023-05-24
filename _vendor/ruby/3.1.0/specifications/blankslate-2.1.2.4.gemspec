# -*- encoding: utf-8 -*-
# stub: blankslate 2.1.2.4 ruby lib

Gem::Specification.new do |s|
  s.name = "blankslate".freeze
  s.version = "2.1.2.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jim Weirich".freeze, "David Masover".freeze, "Jack Danger Canty".freeze]
  s.date = "2011-03-16"
  s.email = "rubygems@6brand.com".freeze
  s.homepage = "http://github.com/masover/blankslate".freeze
  s.rubygems_version = "3.3.26".freeze
  s.summary = "BlankSlate extracted from Builder.".freeze

  s.installed_by_version = "3.3.26" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
  else
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
  end
end
