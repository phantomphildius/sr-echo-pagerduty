require 'json'

module PagerDuty
  class OnCall
    attr_reader :user_id

    PATH = '/oncalls'.freeze

    def initialize(user_id)
      @user_id = user_id
    end

    def sorted_on_call_names
      on_calls_sorted_by_priority = json_resources.sort_by { |res| res['escalation_level'] }
      on_calls_sorted_by_priority.map { |on_call| on_call['user']['summary'] }.join(', ')
    end

    private

    def json_resources
      @resources ||= PagerDuty::Request.get(user_id, PATH)
      JSON.parse(@resources.body)['oncalls']
    end
  end
end
