module PagerDuty
  class Incident
    PATH = "/incidents".freeze
    NO_ALERTS = "There are no triggered alerts".freeze
    def self.json_resources
      @resources ||= PagerDuty::Request.where(PATH, {statuses: ["triggered"], sort_by: "created_at:desc"})
      binding.pry
      JSON.parse(@resources.body)["incidents"]
    end

    def self.last_alert_title
     alerts = self.json_resources
     alerts.empty? ? NO_ALERTS : alerts.first["title"]
    end
  end
end
