module PagerDuty
  class Incident
    PATH = "/incidents".freeze
    NO_ALERTS = "There are no triggered alerts".freeze
    def self.json_resources(user_id)
      @resources ||= PagerDuty::Request.where(user_id, PATH, {statuses: ["triggered"], sort_by: "created_at:desc"})
      JSON.parse(@resources.body)["incidents"]
    end

    def self.last_alert_title(user_id)
     alerts = self.json_resources(user_id)
     alerts.empty? ? NO_ALERTS : alerts.first["title"]
    end
  end
end
