describe 'List webpage views' do
  let(:parser)         { Parser.new(file_path) }
  let(:file_path)      { "./spec/fixtures/files/test_webserver.log" }

  before(:each) { parser.convert_file }

  it 'returns a list of webpages with most page views ordered from most pages views to less page views' do
    output = "All page views (descending):\n/help_page/1 5 views\n/contact 4 views\n/home 1 view" + Formatter::DIVIDER
    expect(parser.list_all_views).to eq output
  end

  it 'returns a list of webpages with most unique page views also ordered' do
    output = "Unique page views (descending):\n/help_page/1 4 unique views\n/contact 2 unique views\n/home 1 unique view"
    expect(parser.list_unique_views).to eq output
  end
end
