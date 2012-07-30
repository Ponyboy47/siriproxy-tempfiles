# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "siriproxy-tempfiles"
  s.version     = "0.1.0b1" 
  s.authors     = ["Ponyboy47"]
  s.email       = [""]
  s.homepage    = ""
  s.summary     = %q{Plugin for testing writing to temporary files}
  s.description = %q{Trying to mae it so siri remembers things}

  s.rubyforge_project = "siriproxy-tempfiles"

  s.files         = `git ls-files 2> /dev/null`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/* 2> /dev/null`.split("\n")
  s.executables   = `git ls-files -- bin/* 2> /dev/null`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
