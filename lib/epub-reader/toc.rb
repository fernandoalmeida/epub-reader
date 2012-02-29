module Epub
  class Toc

    def initialize(tocfile, reader)
      @tocfile = tocfile
      @reader  = reader
      @file    = @reader.file
      @content = get_toc_content
      @xml     = Nokogiri::XML(@content).remove_namespaces!
    end

    def content
      if ncx?
        if has_toc?
          ncx_to_html
        else
          spine_to_html
        end
      else
        @content
      end
    end
    
    def pages
      points = @xml.css("ncx navMap navPoint")
      items  = @reader.package.reading_order
      if ncx? && has_toc? && points.size > 1
        points.map do |point|
          title = point.css('navLabel > text').first.text
          file_path  = @reader.package.relative_content_path + point.css('content').attr('src').to_s
          Page.new(title, file_path, @reader.file)
        end
      else
        items.map do |item|
          title = ""
          file_path  = @reader.package.relative_content_path + item.attr('href').to_s
          Page.new(title, file_path, @reader.file)
        end
      end
    end
    
    private
      
    def ncx?
      @tocfile.match(/(\.ncx)$/)
    end

    def has_toc?
      @xml.css('navMap > navPoint').size > 0
    end

    def get_toc_content
      begin
        @reader.file.get_input_stream(@tocfile).read
      rescue
        ""
      end
    end

    # TODO: Add Stylesheets
    # TODO: Convert nested navigation
    # TODO: Refactoring to DRY with spine_to_html
    def ncx_to_html
      html     = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<html xmlns="http://www.w3.org/1999/xhtml" profile="http://www.idpf.org/epub/30/profile/content/">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <title>#{title}</title>
  </head>
  <body>
    <section>
      <nav id="toc" epub:type="toc">
        <ol>
EOF
          selector = "ncx > navMap > navPoint"
          @xml.css(selector).each do |point|
            html += "<li id=\"#{point.attr('id').to_s}\"><a href=\"#{point.css('content').attr('src').to_s}\">#{point.css('navLabel text').text}</a></li>"
          end
          html += <<EOF
        </ol>
      </nav>
    </section>
  </body>
</html>
EOF
      html
    end

    def spine_to_html
      html     = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<html xmlns="http://www.w3.org/1999/xhtml" profile="http://www.idpf.org/epub/30/profile/content/">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <title>#{title}</title>
  </head>
  <body>
    <section>
      <nav id="toc" epub:type="toc">
        <ol>
EOF
      @reader.package.reading_order.each do |item|
        link = item.attr('href').to_s
        html += "<li id=\"#{item.attr('id').to_s}\"><a href=\"#{link}\">#{link[0,link.rindex('.')]}</a></li>"        
      end
      html += <<EOF
        </ol>
      </nav>
    </section>
  </body>
</html>
EOF
      html
    end

    def title
      root.css('docTitle > text').text
    end
    
    def root
      @xml.css('ncx')
    end

    def navmap
      root.css('navMap')
    end

  end
end
