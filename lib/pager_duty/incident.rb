module PagerDuty
  class Incident
    PATH = '/incidents'.freeze
    NO_ALERTS = 'There are no triggered alerts'.freeze
    def self.json_resources(user_id)
      @resources ||= PagerDuty::Request.where(user_id, PATH, statuses: ['triggered'], sort_by: 'created_at:desc')
      JSON.parse(@resources.body)['incidents']
    end

    def self.last_alert_title(user_id)
      alerts = json_resources(user_id)
      title = alerts.empty? ? NO_ALERTS : alerts.first['title']
      id = alerts.empty? ? nil : alerts.first['id']
      {
        title: title,
        session_attributes: {
          alert_id: id
        }
      }
    end
  end
end
