describe Oystercard do
  let(:entry_station) { 'Station A' }
  let(:exit_station) { 'Station B' }

  # These two sets of steps are completed a lot
  def top_up_touch_in
    subject.top_up(10)
    subject.touch_in(entry_station)
  end

  def top_up_touch_in_touch_out
    top_up_touch_in
    subject.touch_out(exit_station)
  end

  context 'On initialization' do
    it '#balance should have £0' do
      expect(subject.balance).to eq 0
    end

    it '#in_journey? should be false' do
      expect(subject.in_journey?).to eq false
    end

    it '@journey_log should exist' do
      expect(subject.journey_log).to be_an_instance_of(Journeylog)
    end
  end

  context '#in_journey?' do
    it 'should return TRUE when a journey has been started' do
      top_up_touch_in
      expect(subject.in_journey?).to be true
    end

    it 'should return FALSE when a journey has been completed' do
      top_up_touch_in_touch_out
      expect(subject.in_journey?).to be false
    end
  end

  describe '#top_up' do
    it 'adds money to the balance of the card' do
      subject.top_up(5)
      expect(subject.balance).to eq 5
    end

    it 'raises an error during top-up when the balance exceeds £90' do
      expect { subject.top_up(Oystercard::LIMIT + 1)
      }.to raise_error "Maximum limit of £#{Oystercard::LIMIT} exceeded"
    end
  end

  context 'journey card usage' do
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

      it 'should reduce card balance by the minimum fare' do
        top_up_touch_in
        expect{ subject.touch_out(exit_station) }.to change {
          subject.balance }.by(-Oystercard::MINIMUM_VALUE)
      end
    end
  end
end
