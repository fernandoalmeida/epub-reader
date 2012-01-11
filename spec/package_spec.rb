require 'spec_helper'

describe Epub::Package do

  before(:all) do
    @file = 'spec/data/valid.epub'
    @reader = Epub::Reader.open(@file)
  end

  it 'get raw content' do
    @reader.package.raw.should_not be_empty
  end

  it 'get file path' do
    @reader.package.path.should_not be_empty
  end

  it 'get media type' do
    @reader.package.mediatype.should eq("application/oebps-package+xml")
  end

  it 'get the epub version' do
    @reader.package.version.should eq(2)
  end

  it 'get the epub unique identifier' do
    @reader.package.identifier.should eq("urn:uuid:bdb0c6b5-5620-440f-9e14-5e1500197941")
  end

  it 'get the content language' do
    @reader.package.language.should eq("en")
  end

  it 'get the content title' do
    @reader.package.title.should eq("Flowers of Evil")
  end

  it 'get the content creator' do
    @reader.package.creator.should eq("Charles Baudelaire")
  end

  it 'get the content contributor' do
    @reader.package.contributor.should eq("ManyBooks.net")
  end

  it 'get the publication date' do
    @reader.package.date.should be_empty
  end

  it 'get the publication source' do
    @reader.package.source.should be_empty
  end

  it 'get the content type' do
    @reader.package.source.should be_empty
  end

  it 'get the full resource list' do
    @reader.package.resources.should_not be_empty
  end

  it 'get the image list' do
    @reader.package.images.size.should eq(1)
  end

  it 'get the html list' do
    @reader.package.html.size.should eq(2)
  end

  it 'get the stylesheet list' do
    @reader.package.stylesheets.size.should eq(1)
  end

  it 'get the javascript list' do
    @reader.package.javascripts.should be_empty
  end

  it 'get the font list' do
    @reader.package.fonts.should be_empty
  end

  it 'get the audio list' do
    @reader.package.audios.should be_empty
  end

  it 'get the table of content (toc)' do
    @reader.package.toc.should eq("toc.ncx")
  end

  it 'get the reading order' do
    list = @reader.package.reading_order
    list.size.should eq(2)
    list[0].attr('idref').should eq('titlepage')
    list[1].attr('idref').should eq('html')
  end

  it 'get the book cover' do
    @reader.package.cover.should eq("cover.jpg")
  end

end
