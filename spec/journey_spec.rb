require 'journey'

describe Journey do
  let(:oyster) { Oystercard.new }
  let(:subject) { Journey.new(1)} # KNOWN PROBLEM: USING A MAIC NUM

  context 'On set-up' do
    it '#in_journey? should be false' do
      expect(subject.in_journey?).to eq false
    end

    it 'should have an empty @journey_history' do
      expect(subject.journey_history).to be_empty
    end
  end

  context 'journey card usage' do
    let(:entry_station) { 'Station A' }
    let(:exit_station) { 'Station B' }

    def top_up_touch_in
      oyster.top_up(10)
      subject.touch_in(entry_station)
    end
    def top_up_touch_in_touch_out
      top_up_touch_in
      subject.touch_out(exit_station)
    end

    describe '#touch_in method' do
      it 'should respond to #touch_in' do
        top_up_touch_in
        expect(subject.in_journey?).to eq true
      end

      it 'should raise an error when balance is below minimum' do
        expect { subject.touch_in(entry_station) }.to raise_error RuntimeError
      end
    end

    describe '#touch_out method' do
      it 'should respond to #touch_out' do
        top_up_touch_in_touch_out
        expect(subject.in_journey?).to eq false
      end

      it 'should record the journey' do
        top_up_touch_in_touch_out
        expect(subject.journey_history.length).to eq 1
      end
    end

    describe 'journey history' do
      it 'should store the journey' do
        top_up_touch_in_touch_out
        expect(subject.journey_history).to include(entry_station => exit_station)
      end
    end

  end

end
