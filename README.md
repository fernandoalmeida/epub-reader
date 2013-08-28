# Overview

EPUB Reader is a Ruby library which helps you to parse EPUB files conforming
as much as possible the specification from IDPF.

# Installation

The recommended installation method is via Rubygems.

    gem install epub-reader

# Usage

Begin by creating a Epub::Reader instance that points to a EPUB file. Document
level information (metadata, toc, page count, etc) is available via this object.

    reader = Epub::Reader.open("somefile.epub")
    puts reader.epub_version
    puts reader.title
    puts reader.author
    puts reader.publication_date
    puts reader.language
    reader.pages.each do |page|
      puts page.title
      puts page.content
    end

# Exceptions

There are two key exceptions that you will need to watch out for when processing a
EPUB file:

FileNotFoundError - The argument passed to Epub::Reader.open('file.epub') is a file
path. If the file does not exist the FileNotFoundError is thrown.

MalformedEpubError - The EPUB appears to be corrupt in some way. If you believe the
file should be valid, or that a corrupt file didn't raise an exception, please
forward a copy of the file to the maintainers using the Bitbucket issue tracker
and we will attempt to improve the code.

MalformedEpubError has some subclasses if you want to detect finer grained issues. If you
don't, 'rescue MalformedEpubError' will catch all the subclassed errors as well.

Any other exceptions should be considered bugs in either Epub::Reader (please
report it!).

# Mantainers

- Fernando Almeida <fernando@fernandoalmeida.net>

# Licensing

This is a proprietary library and all rights are reserved to eBookPlus.com.

# References

[What is EPUB 3?](http://shop.oreilly.com/product/0636920022442.do)

[EPUB Publications Specifications](http://idpf.org/epub/30/spec/epub30-publications.html)

[EPUB Content Documents Specifications](http://idpf.org/epub/30/spec/epub30-contentdocs.html)

[EPUB Open Container Formats Specifications](http://idpf.org/epub/30/spec/epub30-ocf.html)

[Shared Workspace for Emerging Specifications and Schemas for EPUB 3](http://code.google.com/p/epub-revision/downloads/list)