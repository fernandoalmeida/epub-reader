module Epub
  class Container
    
    attr_reader :packages
    
    def initialize(c)
      @container = c
      @xml       = Nokogiri::XML(@container)
      @packages  = []
      @xml.css('container rootfiles rootfile').each do |rootfile|
        @packages << Package.new(rootfile)
      end
    end

    def raw
      @container.to_s
    end

    def package(index = 0)
      @packages[index]
    end
  end
end
