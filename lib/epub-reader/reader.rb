module Epub
  class Reader

    EPUB_MIMETYPE = "application/epub+zip"

    attr_reader :filepath, :file
    
    def initialize(f)
      raise(FileNotFoundError, "File not found") unless File.exists?(f)
      @filepath  = f.to_s
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

    # TODO: To parse other META-INF files
    # signatures.xml [optional]
    # Contains digital signatures for various assets.

    # encryption.xml [optional]
    # Contains information about the encryption of Publication resources. (This file is required if font obfuscation is used.)

    # metadata.xml [optional]
    # Used to store metadata about the container.

    # rights.xml [optional]
    # Used to store information about digital rights.

    # manifest.xml [allowed]
    # A manifest of container contents as allowed by Open Document Format [ODF]. 

    # Convenient method
    def package(index = 0)
      container.package(index)
    end

    private

    def valid?
      valid_mimetype? && valid_container? && valid_package?
    end

    def valid_mimetype?
      mimetype == EPUB_MIMETYPE
    end

    def valid_container?
      !container.nil?
    end

    def valid_package?
      !package.nil?
    end

  end
end
