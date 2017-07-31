intent 'OnCall' do |user_id|
  respond(PagerDuty::OnCall.sorted_on_call_names(user_id))
end
