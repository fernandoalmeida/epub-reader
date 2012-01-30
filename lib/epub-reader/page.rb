module Epub
  class Page
    def initialize(title, path, file)
      @title = title
      @path  = path
      @file  = file
    end
    
    attr_reader :title, :path
    
    def content
      @content ||= get_page_content
    end

    private

    def get_page_content
      begin
        @file.get_input_stream(@path).read.force_encoding(Encoding::UTF_8)
      rescue
        ""
      end
    end

  end
end
