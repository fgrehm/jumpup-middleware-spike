class Jumpup::Action::Git::Push < Jumpup::Action::Base
  def call(env)
    puts '- Running git push'
    @app.call(env)
  end
end
