require 'spec_helper'

describe Epub::Page do

  before(:all) do
    file   = 'spec/data/valid.epub'
    reader = Epub::Reader.open(file)
    @toc   = Epub::Toc.new(reader.package.toc, reader.file)
    @page  = @toc.pages.last
  end

  it 'get page title' do
    @page.title.should eq('Copyright Page')
  end

  it 'get page path' do
    @page.path.should eq('OPS/copyright.xhtml')
  end

  it 'get page content' do
    @page.content.should match('<html.*>')
    @page.content.should match('Produced by Daniel Lazarus and Jonesey')
  end
end
