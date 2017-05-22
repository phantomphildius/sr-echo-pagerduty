require 'json'

module PagerDuty
  class OnCall
    PATH = "/oncalls".freeze
    def self.json_resources
      @resources ||= PagerDuty::Request.get(PATH)
      JSON.parse(@on_calls.body)["oncalls"]
    end

    def self.sorted_on_calls_by_priority
      self.json_resources.sort_by! { |resource| resource["escalation_level"] }
    end

    def self.on_call_names
      sorted_on_calls_by_priority.map{ |on_call| on_call["user"]["summary"] }
    end
  end
end
