class Jumpup::Action::Git::PullRebase < Jumpup::Action::Base
  def call(env)
    puts '- Running pull --rebase'
    @app.call(env)
  end
end
