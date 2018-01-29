module PagerDuty
  class Incident
    Alert = Struct.new(:id, :title)

    PATH = '/incidents'.freeze
    NO_ALERTS = 'There are no triggered alerts'.freeze

    attr_reader :user_id

    def initialize(user_id)
      @user_id = user_id
    end

    def last_alert
      alert = last_json_resource || {}
      Alert.new(
        id: alert.fetch('id', nil),
        title: alert.fetch('title', NO_ALERTS)
      )
    end

    def update_last_alert(action)
      alert = last_json_resource || {}
      alert['status'] = action
      begin
        update_resource(alert)
        "Alert successfully #{action}d"
      rescue StandardError => e
        "#{e.message}"
      end
    end

    private

    def update_resource(alert)
      PagerDuty::Request.put(
        user_id,
        PATH,
        alert
      )
    end

    def last_json_resource
      JSON.parse(resources.body)['incidents'].first
    end

    def resources
      @resources ||= PagerDuty::Request.where(
        user_id,
        PATH,
        statuses: ['triggered'],
        sort_by: 'created_at:desc'
      )
    end
  end
end
