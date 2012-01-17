module Epub
  class Toc

    def initialize(tocfile, file)
      @tocfile = tocfile
      @file    = file
      @content = get_toc_content
      @xml     = Nokogiri::XML(@content).remove_namespaces!
    end

    def content
      if ncx?
        ncx_to_html
      else
        @content
      end
    end

    def pages
      @xml.css("ncx > navMap > navPoint").map do |point|
        title = point.css('navLabel text').text
        path  = @tocfile[0, @tocfile.rindex('/')+1] + point.css('content').attr('src').to_s
        Page.new(title, path, @file)
      end
    end

    private

    def ncx?
      @tocfile.match(/(\.ncx)$/)
    end

    def get_toc_content
      begin
        @file.get_input_stream(@tocfile).read
      rescue
        nil
      end
    end

    # TODO: Add Stylesheets
    # TODO: Convert nested navigation
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
