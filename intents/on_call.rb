intent 'OnCall' do
  respond(PagerDuty::OnCall.on_call_names)
end
