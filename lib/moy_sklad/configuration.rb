module MoySklad

  extend self

  attr_accessor :username
  attr_accessor :password
  attr_accessor :currency

  def config(&block)
    instance_eval(&block)
  end
end
