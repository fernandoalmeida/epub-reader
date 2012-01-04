module Epub
  class Container
    
    attr_reader :packages
    
    def initialize(file)
      @container = get_container_content(file)
      @xml       = Nokogiri::XML(@container)
      @packages  = []
      @xml.css('container rootfiles rootfile').each do |rootfile|
        @packages << Package.new(rootfile, file)
      end
    end

    def raw
      @container.to_s
    end

    def package(index = 0)
      @packages[index]
    end
    
    private

    def get_container_content(file)
      begin
        file.get_input_stream('META-INF/container.xml').read
      rescue
        nil
      end
    end

  end
end
