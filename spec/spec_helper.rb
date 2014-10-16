require 'rspec'
require 'ms_config.rb'
require 'moysklad/configuration'

Moysklad.config do
  @username = ENV["MSKL_USER"]
  @password = ENV["MSKL_PASS"]

  # Some useful stuff
  @currency = "131bf5ff-1ee5-11e4-67ed-002590a28eca"
end

require 'moysklad'
