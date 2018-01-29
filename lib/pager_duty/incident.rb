module PagerDuty
  class Incident
    Alert = Struct.new(:id, :title)

    PATH = '/incidents'.freeze
    NO_ALERTS = 'There are no triggered alerts'.freeze

    attr_reader :user_id

    def initialize(user_id)
      @user_id = user_id
    end

    def last_alert(user_id)
      alert = json_resources.first || {}
      Alert.new(
        id: alert.fetch('id', nil),
        title: alert.fetch('title', NO_ALERTS)
      )
    end

    private

    def json_resources
      JSON.parse(resources.body)['incidents']
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
