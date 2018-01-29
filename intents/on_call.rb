intent 'OnCall' do |user_id|
  pd = PagerDuty::OnCall.new(user_id)
  respond(pd.sorted_on_call_names)
end
