intent 'UpdateLastIncident' do |user_id|
  pd = PagerDuty::Incident.new(user_id)
  respond(pd.update_last_alert)
end

