require 'parser'

describe Parser do
  subject(:parser)    { described_class.new(file_path, view_class: view_class) }
  let(:view_class)    { double :view_class, new: view }
  let(:view)          { double :view }
  let(:file)          { double :file }
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
end
