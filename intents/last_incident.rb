intent 'LastIncident' do
  respond(PagerDuty::Incident.last_alert_title)
end
