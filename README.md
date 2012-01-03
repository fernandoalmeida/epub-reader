# EPUB Reader

EPUB Reader is a Ruby library which helps you to parse EPUB files conforming
as much as possible the specification from IDPF.

# Installation

The recommended installation method is via Rubygems.

    gem install epub-reader

# Usage

Begin by creating a EPUB::Reader instance that points to a PDF file. Document
level information (metadata, toc, page count, etc) is available via this object.

    reader = EPUB::Reader.open("somefile.epub")
    
    # comming soon
    puts reader.title
    puts reader.isbn
    puts reader.author
    puts reader.pages