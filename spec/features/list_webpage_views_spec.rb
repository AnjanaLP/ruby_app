describe 'List webpage views' do
  let(:parser)         { Parser.new(file_path) }
  let(:file_path)      { "./spec/fixtures/files/test_webserver.log" }

  it 'returns a list of webpages with most page views ordered from most pages views to less page views' do
    expect(parser.list_views).to eq "/help_page/1 4 views\n/contact 3 views\n/home 2 views\n/about/2 1 views"
  end
end
