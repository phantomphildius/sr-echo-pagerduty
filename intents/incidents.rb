intent 'Incidents' do |user_id|
  alerts = PagerDuty::Incident.new(user_id).triggered_alerts
  respond(alerts.map(&:title).join(', '))
end
