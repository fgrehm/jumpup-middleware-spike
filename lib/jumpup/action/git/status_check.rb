class Jumpup::Action::Git::StatusCheck < Jumpup::Action::Base
  def call(env)
    puts '- Checking if git tree is clean'
    @app.call(env)
  end
end
