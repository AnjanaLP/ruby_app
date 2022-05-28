require 'parser'

describe Parser do
  subject(:parser)    { described_class.new(file_path, view_class: view_class) }
  let(:view_class)    { double :view_class, new: view }
  let(:view)          { double :view }
  let(:file_path)     { "./spec/fixtures/files/test_webserver.log" }

  before(:each) { parser.convert_file }

  describe '#convert_file' do
    it 'creates a new view object for each line of the file' do
      expect(view_class).to have_received(:new).exactly(10).times
    end

    it 'passes the url and ip address to the new view object' do
      expect(view_class).to have_received(:new).with("/contact", "184.123.665.067").twice
    end
  end

  describe '#list_all_views' do
    it 'returns a list of webpages with thier view count in descending view count order' do
      urls = ['/help', '/home', '/about', '/contact', '/home', '/home', '/home', '/about', '/about', '/contact']
      allow(view).to receive(:url).and_return(*urls)
      output = "All page views (descending):\n/home 4 views\n/about 3 views\n/contact 2 views\n/help 1 view\n\n"
      expect(parser.list_all_views).to eq output
    end
  end

  describe '#list_unique_views' do
    it 'returns a list of webpages with unique view count' do
      allow(view).to receive(:url).and_return('/help')
      allow(view).to receive(:ip_address).and_return('1234', '1321', '1234', '1234', '1234')
      output = "Unique page views (descending):\n/help 2 unique views"
      expect(parser.list_unique_views).to eq output
    end
  end
end
