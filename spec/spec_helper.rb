require 'rspec'
require 'moy_sklad/configuration'

MoySklad.configure do |config|
  config.user_name = ENV["MSKL_USER"]
  config.password = ENV["MSKL_PASS"]
end

require 'moy_sklad'
require 'ms_config'
