require 'station'

describe Station do
  let(:station) { 'Victoria Station' }
  let(:zone) { 1 }
  let(:subject) { Station.new(station, zone) }

  context 'On set-up' do
    it 'Has a name' do
      expect(subject.name).to eq station
    end
    it 'Has a zone' do
      expect(subject.zone).to eq zone
    end
  end
end
