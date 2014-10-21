require 'yaml'

module MoySklad::Model
  class Country < MoySklad::Client::Base
    class << self
      def uuid_from_code(code)
        @_country_cache ||= YAML.load_file(File.join(File.dirname(__FILE__), 'data', 'country_codes.yml'))
        @_country_cache[code.to_s]
      end
    end
  end
end
