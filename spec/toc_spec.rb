# -*- coding: utf-8 -*-
require 'spec_helper'

describe Epub::Toc do

  before(:all) do
    file   = 'spec/data/valid.epub'
    reader = Epub::Reader.open(file)
    @toc    = Epub::Toc.new(reader.package.toc, reader.file)
    @html   = Nokogiri::XML(@toc.content)
  end

  it 'convert <ncx>      to <html>' do
    @html.css('html').size.should eq(1)
  end

  it 'convert <docTitle> to <title>' do
    @html.css('head > title').text.should eq("Moby-Dick")
  end

  it 'convert <navMap>   to <nav>' do
    @html.css('nav').size.should eq(1)
  end

  it 'convert <navPoint> to <a>' do
    @html.css('li > a').size.should eq(142)
  end

end
