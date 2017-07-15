require 'active_support/deprecation'

module ArJdbc

  # @private
  AR40 = ::ActiveRecord::VERSION::MAJOR > 3
  # @private
  AR42 = ::ActiveRecord::VERSION::STRING >= '4.2'

  class << self

    def warn(message, once = nil)
      super(message) || true if warn?(message, once)
    end

    def deprecate(message, once = nil) # adds a "DEPRECATION WARNING: " prefix
      ::ActiveSupport::Deprecation.warn(message, caller) || true if warn?(message, once)
    end

    private

    @@warns = nil
    @@warns = false if ENV_JAVA['arjdbc.warn'].eql? 'false'

    def warn?(message, once)
      return nil if @@warns.equal?(false) || ! message
      warns = @@warns ||= ( require 'set'; Set.new )
      return false if warns.include?(message)
      warns << message.dup if once
      true
    end

  end

  require 'arjdbc/jdbc/adapter'

  if ENV_JAVA['arjdbc.extensions.discover'].eql? 'true'
    self.discover_extensions
  else
    require 'arjdbc/discover'
  end
end