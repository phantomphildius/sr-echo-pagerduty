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
      alert = json_resources.first || {}
      build_alert(alert)
    end

    def triggered_alerts
      alerts = json_resources.empty? ? [{}] : json_resources
      alerts.map { |alert| build_alert(alert) }
    end

    def update_last_alert(action)
      alert = json_resources.first
      update_resource(alert, action)
      'Alert successfully updated, but just make sure its okay in the app'
    rescue StandardError
      'Something went wrong check the app'
    end

    private

    def update_resource(alert, action)
      alert['status'] = action
      PagerDuty::Request.put(user_id, PATH, alert)
    end

    def json_resources
      JSON.parse(resources.body)['incidents']
    end

    def resources
      @resources ||= PagerDuty::Request.where(
        user_id,
        PATH,
        TRIGGERED_ALERT_OPTIONS
      )
    end

    def json_resource
      alerts = PagerDuty::Request.get(user_id, PATH, alert_id)
      JSON.parse(alerts.body)['incident']
    end

    def build_alert(alert)
      Alert.new(
        alert.fetch('id', nil),
        alert.fetch('title', NO_ALERTS)
      )
    end
  end
end
