module Epub
  class Package
    
    def initialize(p)
      @package = p
    end

    def raw
      @package.to_s
    end

    def path
      @package.attr('full-path')
    end

    def mediatype
      @package.attr('media-type')
    end

  end
end
