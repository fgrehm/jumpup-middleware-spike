class Jumpup::Action::ValidateConfig < Jumpup::Action::Base
  def call(env)
    puts '- Validating config'
    @app.call(env)
  end
end
