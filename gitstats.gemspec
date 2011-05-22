# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "gitstats/version"

Gem::Specification.new do |s|
  s.name        = "gitstats"
  s.version     = GitStats::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Utkarsh Kukreti"]
  s.email       = ["utkarshkukreti@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Generate statistics for any Git repository, from your command line.}
  s.description = %q{Generate statistics for any Git repository, from your command line.}

  s.rubyforge_project = "gitstats"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'haml', '~>3.1.1'
  s.add_dependency 'slop', '~>1.6.0'
  s.add_development_dependency 'rspec', '~>2.6.0'
end
