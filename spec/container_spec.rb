require 'spec_helper'

describe Epub::Container do

  before(:all) do
    @file = 'spec/data/valid.epub'
    @epub = Epub::Reader.open(@file)
  end

  it 'get raw content' do
    @epub.container.raw.should_not be_empty
  end

  it 'get package documents' do
    @epub.container.packages.should_not be_empty
  end

  it 'get default package document' do
    @epub.container.package.should be_a(Epub::Package)
  end

end
