`rake install`
require 'rubygems'
require 'epub-reader'

hd = '/home/fernando/trabalho/livros_e_apostilas/EPUB/hd.epub'

f1 = Epub::Reader.open(hd)

puts f1.title
