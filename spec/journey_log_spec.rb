describe Journeylog do
  let(:entry_station) { 'Station A' }

  context 'on set-up' do
    it 'has an empty #journey_history array' do
      expect(subject.journey_history).to be_empty
    end
  end
  context '#start' do
    it 'creates a new journey' do
      subject.start(entry_station)
      expect(subject.journey_history).not_to be_empty
    end
  end
end
