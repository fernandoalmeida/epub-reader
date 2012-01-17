# Overview

EPUB Reader is a Ruby library which helps you to parse EPUB files conforming
as much as possible the specification from IDPF.

# Installation

The recommended installation method is via Rubygems.

    gem install epub-reader

# Usage

Begin by creating a EPUB::Reader instance that points to a EPUB file. Document
level information (metadata, toc, page count, etc) is available via this object.

    reader = EPUB::Reader.open("somefile.epub")
    puts reader.epub_version
    puts reader.title
    puts reader.author
    puts reader.publication_date
    puts reader.language
    reader.pages.each do |page|
      puts page.title
      puts page.content
    end

# References

[What is EPUB 3?](http://shop.oreilly.com/product/0636920022442.do)

[EPUB Publications Specifications](http://idpf.org/epub/30/spec/epub30-publications.html)

[EPUB Content Documents Specifications](http://idpf.org/epub/30/spec/epub30-contentdocs.html)

[EPUB Open Container Formats Specifications](http://idpf.org/epub/30/spec/epub30-ocf.html)

[Shared Workspace for Emerging Specifications and Schemas for EPUB 3](http://code.google.com/p/epub-revision/downloads/list)