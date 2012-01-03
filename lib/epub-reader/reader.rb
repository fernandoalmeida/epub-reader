module Epub
  class Reader

    EPUB_MIMETYPE = "application/epub+zip"

    attr_reader :filename, :file
    
    def initialize(f)
      raise(FileNotFoundError, "File not found") unless File.exists?(f)
      @filename  = f.to_s
      @file      = EpubFile.new(f)
      raise(MalformedFileError, "Invalid EPUB file format") unless valid?
    end
    
    def Reader.open(f)
      reader = Reader.new(f)
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

    def container
      begin
        @container ||= Container.new(file.get_input_stream('META-INF/container.xml').read)
      rescue
        nil
      end
    end

    private

    def valid?
      valid_mimetype? && valid_container?
    end

    def valid_mimetype?
      mimetype == EPUB_MIMETYPE
    end

    def valid_container?
      !container.nil?
    end
  end
end
