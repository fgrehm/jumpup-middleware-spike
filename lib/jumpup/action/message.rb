class Jumpup::Action::Message < Jumpup::Action::Base
  def initialize(app, env, message)
    @app     = app
    @message = message
  end

  def call(env)
    puts "MESSAGE: #{@message}"
    @app.call(env)
  end
end
