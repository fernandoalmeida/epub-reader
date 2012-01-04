module Epub
  class Package

    def initialize(rootfile, file)
      @rootfile = rootfile
      @package  = get_package_content(file)
      @xml = Nokogiri::XML(@package)
      @xml.remove_namespaces!
    end

    def raw
      @package.to_s
    end

    def path
      @rootfile.attr('full-path')
    end

    def mediatype
      @rootfile.attr('media-type')
    end

    def version
      root.attr('version').to_s
    end

    def identifier
      identifiers.css("[id=#{unique_identifier}]").text
    end

    # TODO: identify language
    # TODO: identify subtitles
    def title
      titles.first.text
    end

    def language
      languages.first.text
    end

    # TODO: to do parse of
    # metadata [required]
    # manifest [required]
    # spine    [required]
    # guide    [optional/deprecated]
    # bindings [optional]

    private

    def get_package_content(file)
      begin
        file.get_input_stream(path)
      rescue
        nil
      end
    end

    def root
      @xml.css('package')
    end

    def unique_identifier
      root.attr('unique-identifier').to_s
    end

    def prefix
      root.attr('prefix').to_s
    end

    def lang
      root.attr('xml:lang').to_s
    end

    def dir
      root.attr('dir').to_s
    end

    def id
      root.attr('id').to_s
    end

    # TODO: to do parse of
    # DCMES Optional Elements [0 or more]
    #   contributor
    #   coverage
    #   creator
    #   date
    #   description
    #   format
    #   publisher
    #   relation
    #   rights
    #   source
    #   subject
    #   type
    # meta [1 or more]
    # OPF2 meta [0 or more]
    # link [0 or more]

    ############
    # Metadata #
    ############
    def metadata
      root.css('metadata')
    end

    def identifiers
      metadata.css('identifier')
    end

    def titles
      metadata.css('title')
    end

    def languages
      metadata.css('language')
    end
  end
end
