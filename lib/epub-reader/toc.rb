module Epub
  class Toc
    def initialize(tocfile, file = nil)
      @tocfile = tocfile
      @content = file ? get_toc_content(file) : tocfile
      @xml     = Nokogiri::XML(@content)
      @xml.remove_namespaces!
    end

    def raw
      @content
    end

    def html
      if ncx?
        ncx_to_html
      else
        @content
      end
    end

    private

    def ncx?
      @tocfile.match(/(\.ncx)$|(<ncx.*>)/)
    end

    def get_toc_content(file)
      begin
        file.get_input_stream(@tocfile).read
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
        html += <<EOF
<li id="#{point.attr('id').to_s}">
  <a href="#{point.css('content').attr('src').to_s}">#{point.css('navLabel text').text}</a>
</li>
EOF
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
