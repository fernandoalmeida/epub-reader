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
    lambda { Epub::Reader.open('not_found.epub') }.should raise_error
  end

  it 'informs the filename' do
    @epub.filename.should eq(@file)
  end

  it 'should have the epub file to handle' do
    @epub.file.should_not be_nil
  end

  it 'informs the mime type' do
    @epub.mimetype.should eq("application/epub+zip")
  end

  it 'validates the file' do
    @epub.should be_valid
    Epub::Reader.open('spec/data/invalid.epub').should_not be_valid
  end

end
