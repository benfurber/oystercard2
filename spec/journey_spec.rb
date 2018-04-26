require 'journey'

describe Journey do
  let(:entry_station) { double 'Station A' }
  let(:subject) { Journey.new(entry_station)}

  context 'On set-up' do
    it 'it has an entry station when provided' do
      expect(subject.entry_station).to eq entry_station
    end

    it 'defaults to nil when no entry station is provided' do
      new_journey = Journey.new
      expect(new_journey.entry_station).to eq nil
    end

    it '#complete? should be false' do
      expect(subject.complete?).to eq false
    end
  end

  context 'journey card usage' do
    let(:exit_station) { 'Station B' }
    before { subject.add_exit_station(exit_station) }

    describe '#add_exit_station method' do
      it 'should respond to #add_exit_station' do
        expect(subject.exit_station).to be exit_station
      end

      it 'then turns #complete? to true' do
        expect(subject.complete?).to be true
      end
    end
  end
end
