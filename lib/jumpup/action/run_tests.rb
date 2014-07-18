class Jumpup::Action::RunTests < Jumpup::Action::Base
  def call(env)
    puts '- Running test'
    @app.call(env)
  end
end
