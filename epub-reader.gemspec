# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "epub-reader/version"

Gem::Specification.new do |s|
  s.name        = "epub-reader"
  s.version     = Epub::Reader::VERSION
  s.authors     = ["Fernando Almeida"]
  s.email       = ["fernando@fernandoalmeida.net"]
  s.homepage    = "http://fernandoalmeida.github.io/epub-reader"
  s.summary     = "A library for accessing the content of EPUB files"
  s.description = "The epub-reader library implements a EPUB parser conforming as much as possible to the EPUB 3 specification from IDPF"

  s.rubyforge_project = "epub-reader"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('rubyzip')
  s.add_dependency('nokogiri')
end
