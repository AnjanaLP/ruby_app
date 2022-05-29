require 'view_manager'

describe ViewManager do
  subject(:view_manager)  { described_class.new(view_class: view_class) }
  let(:view_class)        { double :view_class, new: view }
  let(:view)              { double :view }

  describe '#add_view' do
    it 'creates a new view instance and passes it a url and ip address' do
      expect(view_class).to receive(:new).with("/help", "123.456.789")
      view_manager.add_view("/help", "123.456.789")
    end
  end

  describe '#sort_all' do
    it 'returns an array of webpages with thier view count in descending view count order' do
      urls = %w[/help /home /about /contact /home /home /home /about /about /contact]
      allow(view).to receive(:url).and_return(*urls)
      10.times { view_manager.add_view("", "") }
      expect(view_manager.sort_all).to eq [["/home", 4], ["/about", 3], ["/contact", 2], ["/help", 1]]
    end
  end

  describe '#sort_unique' do
    it 'returns an array of webpages with thier unique view count' do
      ip_1, ip_2, ip_3 = %w[126.318.035.038 184.123.665.067 802.683.925.780]
      ip_addresses = [ip_1, ip_2, ip_3, ip_1, ip_3]
      allow(view).to receive(:url).and_return('/help')
      allow(view).to receive(:ip_address).and_return(*ip_addresses)
      5.times { view_manager.add_view("", "") }
      expect(view_manager.sort_unique).to eq [["/help", 3]]
    end
  end
end
