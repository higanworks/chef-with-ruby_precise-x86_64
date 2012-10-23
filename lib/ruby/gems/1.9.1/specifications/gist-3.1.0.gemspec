# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "gist"
  s.version = "3.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chris Wanstrath", "Andr\u{e9} Arko"]
  s.date = "2012-03-22"
  s.description = "  Creates Gists (pastes) on gist.github.com from standard input or\n  arbitrary files. Can link to your GitHub account, create private gists,\n  and enable syntax highlighting.\n"
  s.email = "andre@arko.net"
  s.executables = ["gist"]
  s.files = ["bin/gist"]
  s.homepage = "http://github.com/defunkt/gist"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Creates Gists from STDIN or files."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
