require "exception_notification/rails"

class ExceptionNotifierConfig
  class << self
    def icon_emoji
      case ENV["USER_ENV"]
      when "development"
        ":clipboard:"
      when "test"
        ":warning:"
      when "production"
        ":male-firefighter:"
      else
        ":paperclip:"
      end
    end

    def environment
      ENV["USER_ENV"] || Rails.env
    end

    def color
      case ENV["USER_ENV"]
      when "development"
        "#eab308"
      when "test"
        "#f97316"
      when "production"
        "#dc2626"
      else
        "#6b7280"
      end
    end

    def blocks
      [
        {
          type: "section",
          text: {
            type: "mrkdwn",
            text: "#{icon_emoji} Complete (Ruby) *#{environment.upcase}* environment"
          }
        },
        {
          type: "section",
          text: {
            type: "mrkdwn",
            text: "Time: #{Time.current}"
          }
        }
      ]
    end
  end
end

ExceptionNotification.configure do |config|
  # Ignore additional exception types.
  # ActiveRecord::RecordNotFound, Mongoid::Errors::DocumentNotFound, AbstractController::ActionNotFound and ActionController::RoutingError are already added.
  # config.ignored_exceptions += %w{ActionView::TemplateError CustomError}

  # Adds a condition to decide when an exception must be ignored or not.
  # The ignore_if method can be invoked multiple times to add extra conditions.
  config.ignore_if do |exception, options|
    !Rails.env.production?
  end

  # Ignore exceptions generated by crawlers
  # config.ignore_crawlers %w{Googlebot bingbot}

  # Notifiers =================================================================

  if ENV.fetch("SLACK_EXCEPTION_NOTIFICATIONS_URL")
    config.add_notifier :slack, {
      webhook_url: ENV.fetch("SLACK_EXCEPTION_NOTIFICATIONS_URL"),
      channel: ENV.fetch("SLACK_EXCEPTION_NOTIFICATIONS_CHANNEL"),
      error_grouping: true,
      additional_parameters: {
        mrkdwn: true,
        color: ExceptionNotifierConfig.color,
        blocks: ExceptionNotifierConfig.blocks
      }
    }
  end
end