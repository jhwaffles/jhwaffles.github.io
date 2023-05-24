# -*- encoding: utf-8 -*-
# stub: listen 1.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "listen".freeze
  s.version = "1.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Thibaud Guillaume-Gentil".freeze, "Maher Sallam".freeze]
  s.date = "2013-09-07"
  s.description = "The Listen gem listens to file modifications and notifies you about the changes. Works everywhere!".freeze
  s.email = ["thibaud@thibaud.me".freeze, "maher@sallam.me".freeze]
  s.homepage = "https://github.com/guard/listen".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.26".freeze
  s.summary = "Listen to file modifications".freeze

  s.installed_by_version = "3.3.26" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<rb-fsevent>.freeze, [">= 0.9.3"])
    s.add_runtime_dependency(%q<rb-inotify>.freeze, [">= 0.9"])
    s.add_runtime_dependency(%q<rb-kqueue>.freeze, [">= 0.2"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
  else
    s.add_dependency(%q<rb-fsevent>.freeze, [">= 0.9.3"])
    s.add_dependency(%q<rb-inotify>.freeze, [">= 0.9"])
    s.add_dependency(%q<rb-kqueue>.freeze, [">= 0.2"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
  end
end
