require 'view'

describe View do
  subject(:view)  { described_class.new("/help_page/1", "126.318.035.038") }

  describe '#url' do
    it "returns it's url" do
      expect(view.url).to eq "/help_page/1"
    end
  end

  describe '#ip_address' do
    it "returns it's ip address" do
      expect(view.ip_address).to eq "126.318.035.038"
    end
  end
end
