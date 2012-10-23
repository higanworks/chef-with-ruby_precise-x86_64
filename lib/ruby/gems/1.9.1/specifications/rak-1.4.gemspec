# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rak"
  s.version = "1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Lucraft"]
  s.date = "2012-01-15"
  s.description = "    Grep replacement, recursively scans directories to match a given Ruby regular expression. Prints highlighted results.\n    Based on the Perl tool 'ack' by Andy Lester.  \n"
  s.email = "dan@fluentradical.com"
  s.executables = ["rak"]
  s.files = ["bin/rak"]
  s.homepage = "http://rak.rubyforge.org"
  s.require_paths = ["lib"]
  s.rubyforge_project = "rak"
  s.rubygems_version = "1.8.23"
  s.summary = "A grep replacement in Ruby, type \"rak pattern\"."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
