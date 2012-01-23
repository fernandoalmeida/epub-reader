module Epub
  class Package

    def initialize(rootfile, file)
      @rootfile = rootfile
      @package  = get_package_content(file)
      @xml = Nokogiri::XML(@package).remove_namespaces!
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
      root.attr('version').to_s.to_i
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

    # TODO: identify role
    # TODO: identify file-as
    # TODO: identify alternate-script
    # TODO: identify display-seq
    def creator
      creators.size > 0 ? creators.first.text : ""
    end

    # TODO: equal to creator
    def contributor
      contributors.size > 0 ? contributors.first.text : ""
    end

    def date
      d = metadata.css('data')
      d.size > 0 ? d.text : ""
    end

    def source
      s = metadata.css('source')
      s.size > 0 ? s.text : ""
    end

    def type
      t = metadata.css('type')
      t.size > 0 ? t.text : ""
    end

    def resources
      manifest.css('item')
    end

    def images
      resources.select{|resource| resource.attr('media-type').to_s.match(/^image\/(gif|jpeg|svg\+xml)/)}
    end

    def html
      resources.css('[media-type="application/xhtml+xml"]')
    end

    def stylesheets
      resources.css('[media-type="text/css"]')
    end

    def javascripts
      resources.css('[media-type="text/javascript"]')
    end

    def fonts
      resources.select{|resource| resource.attr('media-type').to_s.match(/application\/(vnd\.ms-opentype|font-woff)/)}
    end

    def audios
      resources.select{|resource| resource.attr('media-type').to_s.match(/^audio\/(mpeg|mp4)/)}
    end

    def toc
      toc_item_id       = spine.attr("toc")
      toc_item_mimetype = "application/x-dtbncx+xml"
      toc_item_selector = toc_item_id ? "##{toc_item_id.to_s}" : '[media-type="#{toc_item_mimetype}"]'
      i   = path.rindex('/').to_i
      dir = i > 0 ? path[0, i+1] : ""
      dir + resources.css(toc_item_selector).attr('href').to_s
    end

    def cover
      cover_meta     = metadata.css('[name="cover"]')
      meta_content   = cover_meta.size == 1 ? cover_meta.attr('content') : nil
      cover_content  = meta_content || manifest.css('[properties="cover-image"]').attr('id').to_s
      cover_content.match(/\.(gif|jpe?g|png)/) ? cover_content : resources.css("##{cover_content}").attr('href').to_s
    end

    # TODO: to parse
    # guide    [optional/deprecated]
    # bindings [optional]

    def reading_order
      spine.css('itemref')
    end

    protected

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
      (spine.attr('page-progression-direction') || root.attr('dir')).to_s
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

    def creators
      metadata.css('creator')
    end

    def contributors
      metadata.css('contributor')
    end

    def meta
      metadata.css('meta')
    end

    def link
      metadata.css('link')
    end

    ############
    # Manifest #
    ############
    def manifest
      root.css('manifest')
    end

    ############
    #  Spine   #
    ############
    def spine
      root.css('spine')
    end

    def reading_order_selectors
      reading_order.map{|item| "##{item.attr('idref')}"}
    end
  end
end
