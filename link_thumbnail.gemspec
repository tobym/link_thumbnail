# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "link_thumbnail/version"

Gem::Specification.new do |s|
  s.name        = "link_thumbnail"
  s.version     = LinkThumbnail::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Toby Matejovsky"]
  s.email       = ["toby.matejovsky@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Retrieve thumbnail images for a given URL.}
  s.description = %q{Given a URL, retrieves thumbnail images (similar to when you share a link on Facebook or Digg).}

  s.rubyforge_project = "link_thumbnail"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency(%q<json>, ["~> 1.4.0"])
  s.add_dependency(%q<nokogiri>, ["~> 1.4.0"])
  s.add_dependency(%q<ruby-readability>, ["~> 0.2.3"])
  s.add_development_dependency(%q<mocha>, [">= 0"])

end
