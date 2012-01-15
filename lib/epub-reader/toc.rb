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

    def ncx_to_html
      nav
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

    def nav(level = 1)
      html     = <<EOF
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops" profile="http://www.idpf.org/epub/30/profile/content/">
  <head>
    <title>#{title}</title>
  </head>
  <body>
    <nav id="toc" epub:type="toc">
      <ol>
EOF
      selector = "ncx > navMap"
      level.times { selector += " > navPoint" }
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
  </body>
</html>
EOF
      html
    end

  end
end
