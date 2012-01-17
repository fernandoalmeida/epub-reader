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

  it 'get the epub version' do
    @reader.epub_version.should eq(3)
  end

  it 'get the title' do
    @reader.title.should eq("Moby-Dick")
  end

  it 'get the author' do
    @reader.author.should eq("Herman Melville")
  end

  it 'get the publication date' do
    @reader.publication_date.should be_empty
  end

  it 'get the language' do
    @reader.language.should eq("en-US")
  end

  it 'get the TOC' do
    @reader.toc.should be_a(Epub::Toc)
  end

  it 'get the pages list' do
    @reader.pages.size.should eq(142)
  end
end
