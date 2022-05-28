require 'parser'

describe Parser do
  subject(:parser)    { described_class.new(file_path, view_class: view_class) }
  let(:view_class)    { double :view_class, new: view }
  let(:view)          { double :view }
  let(:file_path)     { "./spec/fixtures/files/test_webserver.log" }

  describe '#views' do
    it 'is initially empty' do
      expect(parser.views).to be_empty
    end
  end

  describe '#convert_file' do
    it 'creates a new view object for each line of the file' do
      expect(view_class).to receive(:new).exactly(10).times
      parser.convert_file
    end

    it 'passes the url and ip address to the new view object' do
      expect(view_class).to receive(:new).with("/contact", "184.123.665.067").twice
      parser.convert_file
    end

    it 'adds the newly created view object to the views array' do
      parser.convert_file
      expect(parser.views.count).to eq 10
    end
  end

  describe '#list_views' do
    it 'returns a list of webpages with thier view count in descending view count order' do
      urls = ['/help', '/home', '/about', '/contact', '/home', '/home', '/home', '/about', '/about', '/contact']
      allow(view).to receive(:url).and_return(*urls)
      expect(parser.list_views).to eq "/home 4 views\n/about 3 views\n/contact 2 views\n/help 1 views"
    end
  end

  describe '#list_unique_views' do
    it 'returns a list of webpages with unique view count' do
      allow(view).to receive(:url).and_return('/help')
      allow(view).to receive(:ip_address).and_return('1234', '1321', '1234', '1234', '1234')
      expect(parser.list_unique_views).to eq "/help 2 views"
    end
  end
end
