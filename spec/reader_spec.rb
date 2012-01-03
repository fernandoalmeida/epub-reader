require 'spec_helper'

describe Epub::Reader do

  before(:all) do
    @file = 'spec/data/valid.epub'
    @epub = Epub::Reader.open(@file)
  end

  it 'open a epub file' do
    @epub.should_not be_nil
  end

  it 'raises an exception if file not found' do
    lambda {Epub::Reader.open('not_found.epub')}.should raise_error
  end

  it 'raises an exception if malformed file' do
    lambda {Epub::Reader.open('spec/data/invalid.epub')}.should raise_error
  end

  it 'get epub file path' do
    @epub.filepath.should eq(@file)
  end

  it 'get epub mime type' do
    @epub.mimetype.should eq("application/epub+zip")
  end

  it 'get epub zipped file handler' do
    @epub.file.should be_a(Epub::EpubFile)
  end

  it 'get the container document handler' do
    @epub.container.should be_a(Epub::Container)
  end

  it 'get the package document handler' do
    @epub.package.should be_a(Epub::Package)
  end

end
