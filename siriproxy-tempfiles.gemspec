# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "siriproxy-tempfiles"
  s.version     = "1.0.0" 
  s.authors     = ["Ponyboy47"]
  s.email       = [""]
  s.homepage    = ""
  s.summary     = %q{A SiriProxy plugin test plugin to write and read files}
  s.description = %q{Trying to see if I can have Siri remember and use items from a file}

  s.rubyforge_project = "siriproxy-tempfiles"

  s.files         = `git ls-files 2> /dev/null`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/* 2> /dev/null`.split("\n")
  s.executables   = `git ls-files -- bin/* 2> /dev/null`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
