class Jumpup::Action::BundleInstall < Jumpup::Action::Base
  def call(env)
    puts '- Running bundle install'
    @app.call(env)
  end
end
