# -*- encoding: utf-8 -*-
# stub: kramdown 1.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "kramdown".freeze
  s.version = "1.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Thomas Leitner".freeze]
  s.date = "2014-01-05"
  s.description = "kramdown is yet-another-markdown-parser but fast, pure Ruby,\nusing a strict syntax definition and supporting several common extensions.\n".freeze
  s.email = "t_leitner@gmx.at".freeze
  s.executables = ["kramdown".freeze]
  s.files = ["bin/kramdown".freeze]
  s.homepage = "http://kramdown.gettalong.org".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--main".freeze, "lib/kramdown/document.rb".freeze]
  s.rubygems_version = "3.3.26".freeze
  s.summary = "kramdown is a fast, pure-Ruby Markdown-superset converter.".freeze

  s.installed_by_version = "3.3.26" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<minitest>.freeze, ["~> 5.0"])
    s.add_development_dependency(%q<coderay>.freeze, ["~> 1.0.0"])
    s.add_development_dependency(%q<stringex>.freeze, ["~> 1.5.1"])
    s.add_development_dependency(%q<prawn>.freeze, ["~> 0.13"])
  else
    s.add_dependency(%q<minitest>.freeze, ["~> 5.0"])
    s.add_dependency(%q<coderay>.freeze, ["~> 1.0.0"])
    s.add_dependency(%q<stringex>.freeze, ["~> 1.5.1"])
    s.add_dependency(%q<prawn>.freeze, ["~> 0.13"])
  end
end
