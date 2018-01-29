intent 'LastIncident' do |user_id|
  alert = PagerDuty::Incident.last_alert_title(user_id)
  respond(alert[:title], alert[:session_attributes])
end
