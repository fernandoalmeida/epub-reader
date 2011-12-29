require 'zip/zipfilesystem'

module Epub
  class Reader

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
    
  end
end
