require 'spec_helper'

describe Epub::Reader do

  before(:all) do
    @epub = Epub::Reader.open('spec/data/valid.epub')
  end

  it 'should open a epub file' do
    @epub.should_not be_nil
  end

  it 'should raise exception if file not found' do
    lambda { Epub::Reader.open('not_found.epub') }.should raise_error
  end

  it 'should have the epub file to handle' do
    @epub.file.should_not be_nil
  end

end
