class SecretFile
  def initialize(secret_data, logger)
    @logger = logger
    @data = secret_data
  end

  def data
    @data if @logger.create_log_entry
  end
end

class SecurityLogger
  def create_log_entry
    # ... implementation omitted ...
  end
end
