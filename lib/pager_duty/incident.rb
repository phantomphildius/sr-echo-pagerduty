require 'json'

module PagerDuty
  class Incident
    Alert = Struct.new(:id, :title)

    PATH = '/incidents'.freeze
    NO_ALERTS = 'There are no triggered alerts'.freeze
    TRIGGERED_ALERT_OPTIONS = {
      statuses: ['triggered'],
      sort_by: 'created_at:desc'
    }.freeze

    attr_reader :user_id

    def initialize(user_id)
      @user_id = user_id
    end

    def last_alert
      alert = last_json_resources.first || {}
      build_alert(alert)
    end

    def triggered_alerts
      alerts = last_json_resources.empty? ? [{}] : last_json_resources
      alerts.map { |alert| build_alert(alert) }
    end

    # TODO
    # def update_last_alert(action)
    #   alert = last_json_resource || {}
    #   alert['status'] = action
    #   begin
    #     update_resource(alert)
    #     "Alert successfully #{action}d"
    #   rescue StandardError => e
    #     (e.message).to_s
    #   end
    # end

    private

    def update_resource(alert)
      PagerDuty::Request.put(user_id, PATH, alert)
    end

    def last_json_resources
      JSON.parse(resources.body)['incidents']
    end

    def resources
      @resources ||= PagerDuty::Request.where(
        user_id,
        PATH,
        TRIGGERED_ALERT_OPTIONS
      )
    end

    def build_alert(alert)
      Alert.new(
        alert.fetch('id', nil),
        alert.fetch('title', NO_ALERTS)
      )
    end
  end
end
