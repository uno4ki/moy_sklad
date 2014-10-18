require 'rspec'
require 'moy_sklad/configuration'

MoySklad.config do
  @username = ENV["MSKL_USER"]
  @password = ENV["MSKL_PASS"]

  # Some useful stuff
  @currency = "131bf5ff-1ee5-11e4-67ed-002590a28eca"
end

require 'moy_sklad'
require 'ms_config'
