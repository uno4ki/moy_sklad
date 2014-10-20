require 'rspec'
require 'moy_sklad'

MoySklad.configure do |config|
  config.user_name = ENV["MSKL_USER"]
  config.password = ENV["MSKL_PASS"]
end

require 'ms_config'
