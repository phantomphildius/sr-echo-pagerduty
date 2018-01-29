module PagerDuty
  class Incident
    attr_reader :title, :alert_id

    PATH = '/incidents'.freeze
    NO_ALERTS = 'There are no triggered alerts'.freeze

    def initialize(id, title)
      @alert_id = id
      @title = title
    end

    def self.json_resources(user_id)
      @resources ||= PagerDuty::Request.where(user_id, PATH, statuses: ['triggered'], sort_by: 'created_at:desc')
      JSON.parse(@resources.body)['incidents']
    end

    def self.last_alert(user_id)
      alert = json_resources(user_id).first || {}
      title = alert.fetch('title', NO_ALERTS)
      id = alert.fetch('id', nil)
      new(id, title)
    end
  end
end
