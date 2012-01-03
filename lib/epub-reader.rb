require 'zip/zipfilesystem'
require "epub-reader/version"
require "epub-reader/reader"
require "epub-reader/epubfile"
require "epub-reader/container"

module Epub
  class FileNotFoundError  < StandardError; end
  class MalformedFileError < StandardError; end
end
