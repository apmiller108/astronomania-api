module ErrorHandler
  class Handler
    def self.handle(error, severity: :error, meta: {})
      Rollbar.send(severity, error, meta)

      log_error(error, severity)
    end

    def self.log_error(error, severity)
      Rails.logger.send(severity, error.message)
    end
  end
end
