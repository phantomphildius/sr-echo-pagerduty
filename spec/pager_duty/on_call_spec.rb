require 'pager_duty/on_call'

RSpec.describe PagerDuty::OnCall do
  before do
    PagerDuty::Oncall.stub(:json_resources).and_return(oncalls)
  end
  subject { PagerDuty::OnCall }
  let(:oncalls) do
    [
      {
        id: '1',
        escalation_level: 2,
        user: { summary: 'Kevin McHale' }
      },
      {
        id: '2',
        escalation_level: 1,
        user: { summary: 'Larry Bird' }
      },
      {
        id: '3',
        escalation_level: 3,
        user: { summary: 'Robert Parish' }
      }
    ]
  end

  describe 'PATH' do
    it 'is equal to /oncalls' do
      expect(PagerDuty::OnCall::PATH).to eq('/oncalls')
    end
  end

  describe '.sorted_on_calls_by_priority' do
    expect(subject.sorted_on_calls_by_priority.first.escalation_level).to eq(1)
    expect(subject.sorted_on_calls_by_priority.last.escalation_level).to eq(3)
  end
end
