require 'parser'

describe Parser do
  subject(:parser)    { described_class.new(file_path, view_manager: view_manager, formatter: formatter) }
  let(:view_manager)  { double :view_manager, sort_all: [['/home', 2]], sort_unique: [['/home', 1]]  }
  let(:formatter)     { double :formatter }
  let(:file_path)     { "./spec/fixtures/files/test_webserver.log" }

  describe '#convert_file' do
    after(:each) { parser.convert_file }

    it 'calls the foreach method on the File class and passes it the file path' do
      expect(File).to receive(:foreach).with(file_path)
    end

    it 'calls the add_view method on the view_manager instance for each line of the file' do
      expect(view_manager).to receive(:add_view).exactly(10).times
    end
  end

  describe '#list_all_views' do
    it 'calls display_all on the formatter instance and passes it the object from calling sort_all on the view_manager instance' do
      expect(formatter).to receive(:display_all).with([['/home', 2]])
      parser.list_all_views
    end
  end

  describe '#list_unique_views' do
    it 'calls display_unique on the formatter instance and passes it the object from calling sort_unique on the view_manager instance' do
      expect(formatter).to receive(:display_unique).with([['/home', 1]])
      parser.list_unique_views
    end
  end
end
