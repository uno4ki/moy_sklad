module MoySklad
  # Returns the global [Configuration](MoySklad/Configuration) object. While you
  # _can_ use this method to access the configuration, the more common
  # convention is to use [MoySklad.configure](MoySklad#configure-class_method).
  #
  # @example
  #     MoySklad.configuration.user_name = 'admin@example'
  # @see MoySklad.configure
  # @see Configuration
  def self.configuration
    @configuration ||= MoySklad::Configuration.new
  end

  # Yields the global configuration to a block.
  # @yield [Configuration] global configuration
  #
  # @example
  #     MoySklad.configure do |config|
  #       config.user_name 'admin@example'
  #       config.password '1234567890'
  #     end
  # @see Configuration
  def self.configure
    yield configuration if block_given?
  end

  # Stores runtime configuration information.
  #
  # @example
  #     MoySklad.configure do |config|
  #       config.user_name 'admin@example'
  #       config.password '1234567890'
  #     end
  #
  # @see MoySklad.configure
  class Configuration
    # User name for authentication.
    # @attr value [String] defaults to `''`
    attr_reader :user_name

    def user_name=(v)
      MoySklad::Client::Base.user = @user_name = v
    end

    # Password for authentication.
    # @attr value [String] defaults to `''`
    attr_reader :password

    def password=(v)
      MoySklad::Client::Base.password = @password = v
    end

    # Base url.
    # @attr value [String] defaults to
    # `'https://online.moysklad.ru/exchange/rest/ms/xml'`
    attr_reader :base_url

    def base_url=(v)
      MoySklad::Client::Base.site = @base_url = v
    end

    # Currency UUID.
    # @attr value [String] defaults to
    # `'131bf5ff-1ee5-11e4-67ed-002590a28eca'`
    attr_accessor :currency

    def initialize
      @user_name = ''
      @password = ''
      @base_url = 'https://online.moysklad.ru/exchange/rest/ms/xml'
      @currency = '131bf5ff-1ee5-11e4-67ed-002590a28eca'
    end
  end
end
