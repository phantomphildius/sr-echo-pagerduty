intent 'LastIncident' do |user_id|
  alert = PagerDuty::Incident.new(user_id).last_alert
  respond(alert[:title], alert_id: alert[:id])
end
