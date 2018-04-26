describe 'Feature Test', :feature do

  subject(:oystercard) { Oystercard.new }
  let(:entry_station)  {Station.new('Oxford Circus', 1)}
  let(:exit_station) { Station.new('London Bridge', 1) }

  it 'logs a standard journey and deducted normal fare' do
    oystercard.top_up(10)
    expect(oystercard.balance).to eq 10
    oystercard.touch_in(entry_station)
    expect(oystercard).to be_in_journey
    oystercard.touch_out(exit_station)
    expect(oystercard).not_to be_in_journey
    expect(oystercard.balance).to eq 9
  end

  it 'trys to touch in twice and deducted penalty fare' do
    oystercard.top_up(10)
    oystercard.touch_in(entry_station)
    oystercard.touch_in(entry_station)
    expect(oystercard).to be_in_journey
    expect(oystercard.journey_log.journey_history.count).to eq 2
    expect(oystercard.balance).to eq 4
  end

  it 'tries to touch out twice and deducted penalty fare' do
    oystercard.top_up(10)
    oystercard.touch_out(exit_station)
    expect(oystercard).not_to be_in_journey
    expect(oystercard.journey_log.journey_history.count).to eq 1
    expect(oystercard.balance).to eq 4
  end
end
