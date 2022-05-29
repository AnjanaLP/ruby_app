require 'parser'

describe Parser do
  subject(:parser)    { described_class.new(file_path, view_class: view_class) }
  let(:view_class)    { double :view_class, new: view }
  let(:view)          { double :view }
  let(:file_path)     { "./spec/fixtures/files/test_webserver.log" }

  describe '#convert_file' do
    after(:each) { parser.convert_file }

    it 'calls the foreach method on the File class and passes it the file path' do
      expect(File).to receive(:foreach).with(file_path)
    end

    it 'creates a new view object for each line of the file' do
      expect(view_class).to receive(:new).exactly(10).times
    end

    it 'passes the url and ip address to the new view object' do
      expect(view_class).to receive(:new).with("/contact", "184.123.665.067").twice
    end
  end

  describe '#list_all_views' do
    it 'returns a list of webpages with thier view count in descending view count order' do
      urls = %w[/help /home /about /contact /home /home /home /about /about /contact]
      allow(view).to receive(:url).and_return(*urls)
      parser.convert_file
      output = "All page views (descending):\n/home 4 views\n/about 3 views\n/contact 2 views\n/help 1 view" + Formatter::DIVIDER
      expect(parser.list_all_views).to eq output
    end
  end

  describe '#list_unique_views' do
    it 'returns a list of webpages with unique view count' do
      ip_1, ip_2, ip_3 = %w[126.318.035.038 184.123.665.067 802.683.925.780]
      ip_addresses = [ip_1, ip_2, ip_3, ip_1, ip_3]
      allow(view).to receive(:url).and_return('/help')
      allow(view).to receive(:ip_address).and_return(*ip_addresses)
      parser.convert_file
      output = "Unique page views (descending):\n/help 3 unique views"
      expect(parser.list_unique_views).to eq output
    end
  end
end
