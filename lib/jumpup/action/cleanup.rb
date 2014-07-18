class Jumpup::Action::Cleanup < Jumpup::Action::Base
  def call(env)
    puts '- Removing temporary and log files'
    @app.call(env)
  end
end
