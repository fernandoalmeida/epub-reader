# `rake install`
require 'rubygems'
require 'epub-reader'

hd = '/home/fernando/Dropbox/trabalho/livros_e_apostilas/EPUB/e_book_Marketing.epub'

f1 = Epub::Reader.open(hd)

puts f1.cover
