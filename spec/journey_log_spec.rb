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

  context '#entry_station?' do
    it 'should have a method' do
      expect(subject).to respond_to(:complete?)
    end

    it 'return true if current journey has a entry station but no exit' do
      subject.start(entry_station)
      expect(subject.complete?).to be true
    end

    it 'returns false if no start method run' do
      expect(subject.complete?).to be false
    end

    it 'returns false if you start and finish' do
      subject.start(entry_station)
      subject.finish(entry_station)
      expect(subject.complete?).to be false
    end
  end

  context '#fare' do
    it 'returns penalty fare on double start' do
      subject.start(entry_station)
      subject.start(entry_station)
      expect(subject.fare).to eq 6
    end
    it 'returns penalty fare on touch out only' do
      subject.finish(entry_station)
      expect(subject.fare).to eq 6
    end

    it 'returns normal fare' do
      subject.start(entry_station)
      subject.finish(entry_station)
      expect(subject.fare).to eq 1
    end
  end

  context '#journeys' do
    it 'should not allow removals/any manipulation to the #journey_history' do
      subject.start(entry_station)
      subject.finish(entry_station)
      subject.journey_history.pop
      expect(subject.journey_history.length).to eq 1
    end
  end

end
