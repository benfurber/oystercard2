require 'oystercard'

describe Oystercard do
  it 'should have £0 #balance on setup' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'adds money to the balance of the card' do
      subject.top_up(5)
      expect(subject.balance).to eq 5
    end

    it 'raises an error during top-up when the balance exceeds 90' do
      expect { subject.top_up(Oystercard::LIMIT + 1)
      }.to raise_error "Maximum limit of £#{Oystercard::LIMIT} exceeded"
    end

    it 'expects balance to equal limit constant' do
      subject.top_up(90)
      expect(subject.balance).to eq Oystercard::LIMIT
    end
  end

  context 'journey card usage' do
    let(:entry_station) { 'Station A' }
    let(:exit_station) { 'Station B' }

    describe '#touch_out method' do
      it 'should reduce card balance by the minimum fare' do
        subject.top_up(10)
        subject.touch_in(entry_station)
        expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Oystercard::MINIMUM_VALUE)
      end
    end
  end
end
