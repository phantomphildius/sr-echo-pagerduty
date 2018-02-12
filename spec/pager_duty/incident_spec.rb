require 'pager_duty/incident'

RSpec.describe PagerDuty::Incident do
  describe 'PATH' do
    it 'equals /incidents' do
      expect(PagerDuty::Incident::PATH).to eq('/incidents')
    end
  end

  describe '#last_alert' do
    it 'returns the last triggered alert' do
      pd_incident = PagerDuty::Incident.new('user-id')
      pd_response = double('response', body: incidents_json)
      allow(pd_incident).to receive(:resources).and_return(pd_response)

      alert = pd_incident.last_alert

      expect(alert['title']).to eq('the roof is on fire')
    end

    it 'returns no the alerts message if nothing is trigged' do
      pd_incident = PagerDuty::Incident.new('user-id')
      incidents_json = { incidents: [] }.to_json
      pd_response = double('response', body: incidents_json)
      allow(pd_incident).to receive(:resources).and_return(pd_response)

      alert = pd_incident.last_alert

      expect(alert['title']).to eq(PagerDuty::Incident::NO_ALERTS)
    end
  end

  describe '#triggered_alerts' do
    it 'returns a list of triggered_alerts' do
      pd_incident = PagerDuty::Incident.new('user-id')
      pd_response = double('response', body: incidents_json)
      allow(pd_incident).to receive(:resources).and_return(pd_response)

      alerts = pd_incident.triggered_alerts

      expect(alerts.length).to eq(2)
      expect(alerts.first.title).to eq('the roof is on fire')
      expect(alerts.last.title).to eq('its broken')
    end

    it 'returns no the alerts message if nothing is trigged' do
      pd_incident = PagerDuty::Incident.new('user-id')
      incidents_json = { incidents: [] }.to_json
      pd_response = double('response', body: incidents_json)
      allow(pd_incident).to receive(:resources).and_return(pd_response)

      alert = pd_incident.last_alert

      expect(alert['title']).to eq(PagerDuty::Incident::NO_ALERTS)
    end
  end

  describe '#update_last_alert' do
    it 'updates an alert' do
      pd_incident = PagerDuty::Incident.new('user-id')
      pd_response = double('response', body: incidents_json)
      allow(pd_incident).to receive(:resources).and_return(pd_response)
      allow(pd_incident).to receive(:update_resource).and_return(true)

      res = pd_incident.update_last_alert('escalate')

      expect(res).to eq('Alert successfully updated, but just make sure its okay in the app')
    end

    it 'returns a failure message if something goes wrong' do
      pd_incident = PagerDuty::Incident.new('user-id')
      pd_response = double('response', body: incidents_json)
      allow(pd_incident).to receive(:resources).and_return(pd_response)
      allow(pd_incident).to receive(:update_resource).and_raise

      res = pd_incident.update_last_alert('escalate')

      expect(res).to eq('Something went wrong check the app')
    end
  end

  # rubocop:disable MethodLength
  def incidents_json
    {
      'incidents': [
        {
          'id': '2',
          'title':  'the roof is on fire',
          'created_at': '2018-02-12T23:30:42Z',
          'status':  'triggered'
        },
        {
          'id': '3',
          'title':  'its broken',
          'created_at': '2018-02-12T21:30:42Z',
          'status':  'triggered'
        }
      ]
    }.to_json
  end
  # rubocop:enable MethodLength
end
