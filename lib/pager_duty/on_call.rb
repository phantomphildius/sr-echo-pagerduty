require 'json'

module PagerDuty
  class OnCall
    PATH = "/oncalls".freeze
    def self.json_resources(user_id)
      @resources ||= PagerDuty::Request.get(user_id, PATH)
      JSON.parse(@resources.body)["oncalls"]
    end

    def self.sorted_on_call_names(user_id)
      on_calls_sorted_by_priority = json_resources(user_id).sort_by { |res| res["escalation_level"] }
      on_calls_sorted_by_priority.map{ |on_call| on_call["user"]["summary"] }.join(", ")
    end
  end
end
