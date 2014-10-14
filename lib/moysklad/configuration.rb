module Moysklad

  extend self

  attr_accessor :username
  attr_accessor :password

  def config(&block)
    instance_eval(&block)
  end
end
