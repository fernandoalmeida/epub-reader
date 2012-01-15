require 'spec_helper'

describe Epub::Reader do

  before(:all) do
    @file = 'spec/data/valid.epub'
    @reader = Epub::Reader.open(@file)
  end

  it 'open a epub file' do
    @reader.should_not be_nil
  end

  it 'raises an exception if file not found' do
    lambda {Epub::Reader.open('not_found.epub')}.should raise_error
  end

  it 'raises an exception if malformed file' do
    lambda {Epub::Reader.open('spec/data/invalid.epub')}.should raise_error
  end

  it 'get epub file path' do
    @reader.filepath.should eq(@file)
  end

  it 'get epub mime type' do
    @reader.mimetype.should eq("application/epub+zip")
  end

  it 'get epub zipped file handler' do
    @reader.file.should be_a(Epub::EpubFile)
  end

  it 'get the container document handler' do
    @reader.container.should be_a(Epub::Container)
  end

  it 'get the package document handler' do
    @reader.package.should be_a(Epub::Package)
  end

  # it 'get the TOC (HTML)' do
  #   @reader.toc.should_not be_empty
  # end

end
