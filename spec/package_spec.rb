require 'spec_helper'

describe Epub::Package do

  before(:all) do
    @file = 'spec/data/valid.epub'
    @epub = Epub::Reader.open(@file)
  end

  it 'get raw content' do
    @epub.package.raw.should_not be_empty
  end

  it 'get file path' do
    @epub.package.path.should_not be_empty
  end

  it 'get media type' do
    @epub.package.mediatype.should eq("application/oebps-package+xml")
  end
end
