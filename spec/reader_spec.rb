require 'spec_helper'

describe Epub::Reader do

  before(:all) do
    @file = 'spec/data/valid.epub'
    @epub = Epub::Reader.open(@file)
  end

  it 'open a epub file' do
    @epub.should_not be_nil
  end

  it 'should raise an exception if file not found' do
    lambda {Epub::Reader.open('not_found.epub')}.should raise_error
  end

  it 'should raise an exception if malformed file' do
    lambda {Epub::Reader.open('spec/data/invalid.epub')}.should raise_error
  end

  it 'informs the filename' do
    @epub.filename.should eq(@file)
  end

  it 'should have the epub file to handle' do
    @epub.file.should be_a(Epub::EpubFile)
  end

  it 'informs the mime type' do
    @epub.mimetype.should eq("application/epub+zip")
  end

  it 'get the container file' do
    @epub.container.should be_a(Epub::Container)
  end

  it 'get the container raw content' do
    @epub.container.raw.should_not be_nil
  end

end
