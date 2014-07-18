#!/usr/bin/env ruby

require_relative 'basic_stack'

module Jumpup
  module Heroku
    module Action
      class ConfirmDeployToProduction < Jumpup::Action::Base
        def call(env)
          puts '- Make sure the user wants to deploy to production or skip if deploying to staging'
          @app.call(env)
        end
      end

      class ValidateConfig < Jumpup::Action::Base
        def call(env)
          puts '- Validating heroku config'
          @app.call(env)
        end
      end

      class CheckHerokuToolbeltInstalled < Jumpup::Action::Base
        def call(env)
          puts '- Check if heroku toolbelt is installed'
          @app.call(env)
        end
      end

      class VerifyAuth < Jumpup::Action::Base
        def call(env)
          puts '- Check if user is logged in'
          @app.call(env)
        end
      end

      class AddRemote < Jumpup::Action::Base
        def call(env)
          puts '- Adding heroku remote'
          @app.call(env)
        end
      end

      class VerifyLock < Jumpup::Action::Base
        def call(env)
          puts '- Verifying lock'
          @app.call(env)
        end
      end

      class Lock < Jumpup::Action::Base
        def call(env)
          puts '- Locking to current user'
          @app.call(env)
        end
      end

      Start = Builder.new do
        use ValidateConfig
        use CheckHerokuToolbeltInstalled
        use AddRemote
        use VerifyAuth
        use VerifyLock
        use Lock
      end

      class CheckIfDbTasksShouldRun < Jumpup::Action::Base
        def call(env)
          puts '- Backup database if database tasks should run'
          @app.call(env)
        end
      end

      class EnableMaintenanceMode < Jumpup::Action::Base
        def call(env)
          puts '- Check if user wants to put app into maintenance mode and do so if wanted or skip if deploy to staging'
          @app.call(env)
        end
      end

      class BackupDB < Jumpup::Action::Base
        def call(env)
          puts '- Backup database if database tasks should run'
          @app.call(env)
        end
      end

      class Tag < Jumpup::Action::Base
        def call(env)
          puts '- Tagging release'
          @app.call(env)
        end
      end

      class Push < Jumpup::Action::Base
        def call(env)
          puts '- Push to heroku'
          @app.call(env)
        end
      end

      class MigrateDB < Jumpup::Action::Base
        def call(env)
          puts '- Migrate Heroku DB if needed'
          @app.call(env)
        end
      end

      class SeedDB < Jumpup::Action::Base
        def call(env)
          puts '- Seed Heroku DB if needed'
          @app.call(env)
        end
      end

      class DisableMaintenanceMode < Jumpup::Action::Base
        def call(env)
          puts '- Disable maintenance mode if was enabled'
          @app.call(env)
        end
      end

      class Restart < Jumpup::Action::Base
        def call(env)
          puts '- Restart app'
          @app.call(env)
        end
      end

      Deploy = Builder.new do
        use CheckIfDbTasksShouldRun
        use EnableMaintenanceMode
        use BackupDB
        use Tag
        use Push
        use MigrateDB
        use SeedDB
        use DisableMaintenanceMode
        use Restart
      end

      class Unlock < Jumpup::Action::Base
        def call(env)
          puts '- Unlocking Heroku'
          @app.call(env)
        end
      end

      Finish = Builder.new do
        use Deploy
        use Unlock
      end
    end
  end
end

HerokuStack = BasicStack.dup.tap do |stack|
  stack.insert       0,                              Jumpup::Heroku::Action::ConfirmDeployToProduction
  stack.insert_after Jumpup::Action::ValidateConfig, Jumpup::Heroku::Action::Start
  stack.insert_after Jumpup::Action::Git::Push,      Jumpup::Heroku::Action::Finish
end

if $0 == __FILE__
  env = {}
  HerokuStack.call(env)
  puts env.inspect
end
