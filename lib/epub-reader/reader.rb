require 'zip/zipfilesystem'

module Epub
  class Reader

    EPUB_MIMETYPE = "application/epub+zip"

    attr_reader :filename, :file
    
    def initialize(file)
      raise FileNotFoundError unless File.exists?(file)
      @filename  = file
      @file      = Zip::ZipFile.open(file)
    end
    
    def Reader.open(file)
      reader = Reader.new(file)
      if block_given?
          yield reader
      else
        reader
      end
    end

    def mimetype
      begin
        file.get_input_stream('mimetype').read
      rescue
        nil
      end
    end
    
    def valid?
      mimetype == EPUB_MIMETYPE
    end
    
  end
end
