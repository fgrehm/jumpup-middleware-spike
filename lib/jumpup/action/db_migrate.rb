class Jumpup::Action::DbMigrate < Jumpup::Action::Base
  def call(env)
    puts '- Running db:migrate'
    @app.call(env)
  end
end
