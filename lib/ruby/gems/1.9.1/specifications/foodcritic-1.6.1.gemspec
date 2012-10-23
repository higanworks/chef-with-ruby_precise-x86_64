# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "foodcritic"
  s.version = "1.6.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andrew Crump"]
  s.date = "2012-08-30"
  s.description = "Lint tool for Opscode Chef cookbooks."
  s.executables = ["foodcritic"]
  s.files = ["bin/foodcritic"]
  s.homepage = "http://acrmp.github.com/foodcritic"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2")
  s.rubygems_version = "1.8.23"
  s.summary = "foodcritic-1.6.1"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<gherkin>, ["~> 2.11.1"])
      s.add_runtime_dependency(%q<gist>, ["~> 3.1.0"])
      s.add_runtime_dependency(%q<nokogiri>, ["= 1.5.0"])
      s.add_runtime_dependency(%q<pry>, ["~> 0.9.8.4"])
      s.add_runtime_dependency(%q<rak>, ["~> 1.4"])
      s.add_runtime_dependency(%q<treetop>, ["~> 1.4.10"])
      s.add_runtime_dependency(%q<yajl-ruby>, ["~> 1.1.0"])
      s.add_runtime_dependency(%q<erubis>, [">= 0"])
    else
      s.add_dependency(%q<gherkin>, ["~> 2.11.1"])
      s.add_dependency(%q<gist>, ["~> 3.1.0"])
      s.add_dependency(%q<nokogiri>, ["= 1.5.0"])
      s.add_dependency(%q<pry>, ["~> 0.9.8.4"])
      s.add_dependency(%q<rak>, ["~> 1.4"])
      s.add_dependency(%q<treetop>, ["~> 1.4.10"])
      s.add_dependency(%q<yajl-ruby>, ["~> 1.1.0"])
      s.add_dependency(%q<erubis>, [">= 0"])
    end
  else
    s.add_dependency(%q<gherkin>, ["~> 2.11.1"])
    s.add_dependency(%q<gist>, ["~> 3.1.0"])
    s.add_dependency(%q<nokogiri>, ["= 1.5.0"])
    s.add_dependency(%q<pry>, ["~> 0.9.8.4"])
    s.add_dependency(%q<rak>, ["~> 1.4"])
    s.add_dependency(%q<treetop>, ["~> 1.4.10"])
    s.add_dependency(%q<yajl-ruby>, ["~> 1.1.0"])
    s.add_dependency(%q<erubis>, [">= 0"])
  end
end
