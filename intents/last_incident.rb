intent 'LastIncident' do |user_id|
  alert = PagerDuty::Incident.last_alert(user_id)
  respond(alert.title, { alert_id: alert.alert_id })
end
