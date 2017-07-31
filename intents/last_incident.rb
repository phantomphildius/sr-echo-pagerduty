intent 'LastIncident' do |user_id|
  respond(PagerDuty::Incident.last_alert_title(user_id))
end
