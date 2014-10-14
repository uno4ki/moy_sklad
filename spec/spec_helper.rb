require 'rspec'
require 'moysklad/configuration'

Moysklad.config do
  @username = ENV["MSKL_USER"]
  @password = ENV["MSKL_PASS"]
end

require 'moysklad'
