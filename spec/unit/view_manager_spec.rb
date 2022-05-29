require 'view_manager'

describe ViewManager do
  subject(:view_manager)  { described_class.new(view_class: view_class) }
  let(:view_class)        { double :view_class, new: view }

  let(:view)              { double :view, url: url,   ip_address: ip   }
  let(:view_1)            { double :view, url: url,   ip_address: ip_1 }
  let(:view_2)            { double :view, url: url_1, ip_address: ip_1 }
  let(:view_3)            { double :view, url: url,   ip_address: ip_1 }

  let(:ip)                { "987.654.321" }
  let(:ip_1)              { "123.456.789" }

  let(:url)               { "/home" }
  let(:url_1)             { "/about" }


  describe '#add_view' do
    it 'creates a new view instance and passes it a url and ip address' do
      expect(view_class).to receive(:new).with(url, ip)
      view_manager.add_view(url, ip)
    end
  end

  describe '#sort_views' do
    context 'when given no argument' do
      it 'returns an array of webpages with all their page views in descending page view order' do
        urls = %w[/help /home /about /contact /home /home /home /about /about /contact]
        allow(view).to receive(:url).and_return(*urls)
        10.times { view_manager.add_view(url, ip) }
        expect(view_manager.sort_views).to eq [["/home", 4], ["/about", 3], ["/contact", 2], ["/help", 1]]
      end
    end

    context 'when given :unique as an argument' do
      it 'returns an array of webpages with their unique page views in descending page view order' do
        allow(view_class).to receive(:new).with(url, ip).and_return(view)
        allow(view_class).to receive(:new).with(url, ip_1).and_return(view_1)
        allow(view_class).to receive(:new).with(url_1, ip_1).and_return(view_2)
        allow(view_class).to receive(:new).with(url, ip_1).and_return(view_3)

        2.times { view_manager.add_view(url, ip_1 ) }
        view_manager.add_view(url, ip)
        view_manager.add_view(url_1, ip_1)

        expect(view_manager.sort_views(:unique)).to eq [[url, 2], [url_1, 1] ]
      end
    end
  end
end
