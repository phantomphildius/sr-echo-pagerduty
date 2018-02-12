require 'pager_duty/on_call'

RSpec.describe PagerDuty::OnCall do
  describe 'PATH' do
    it 'is equal to /oncalls' do
      expect(PagerDuty::OnCall::PATH).to eq('/oncalls')
    end
  end

  describe '#sorted_on_call_names' do
    oncall_users = [
      {
        'id' => '1',
        'escalation_level' => 2,
        'user' => { 'summary' => 'Kevin McHale' }
      },
      {
        'id' => '2',
        'escalation_level' =>  1,
        'user' => { 'summary' => 'Larry Bird' }
      },
      {
        'id' => '3',
        'escalation_level' => 3,
        'user' => { 'summary' => 'Robert Parish' }
      }
    ]

    it 'returns sorted oncall names' do
      pd_oncall = PagerDuty::OnCall.new('user-id')
      allow(pd_oncall).to receive(:json_resources).and_return(oncall_users)

      oncalls = pd_oncall.sorted_on_call_names

      expect(oncalls.split(', ').length).to eq(3)
      expect(oncalls).to eq('Larry Bird, Kevin McHale, Robert Parish')
    end
  end
end
