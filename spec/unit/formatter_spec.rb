require 'formatter'

describe Formatter do
  subject(:formatter)   { described_class.new }
  let(:views)           { [[ "/home", 8], ["/about", 6], ["/help", 2]] }
  let(:single_view)     { [[ "/home", 8], ["/about", 1]]  }

  describe '#display_all' do
    it "nicely formats the output with an 'All' header and extra blank space at the end" do
      output = "All page views (descending):\n/home 8 views\n/about 6 views\n/help 2 views\n\n"
      expect(formatter.display_all(views)).to eq output
    end

    context 'when there is only one view' do
      it 'uses the singular' do
        output = "All page views (descending):\n/home 8 views\n/about 1 view\n\n"
        expect(formatter.display_all(single_view)).to eq output
      end
    end
  end

  describe '#display_unique' do
    it "nicely formats the output with a 'Unique' header and specifies the views are unique" do
      output = "Unique page views (descending):\n/home 8 unique views\n/about 6 unique views\n/help 2 unique views"
      expect(formatter.display_unique(views)).to eq output
    end

    context 'when there is only one view' do
      it 'uses the singular' do
        output = "Unique page views (descending):\n/home 8 unique views\n/about 1 unique view"
        expect(formatter.display_unique(single_view)).to eq output
      end
    end
  end
end
