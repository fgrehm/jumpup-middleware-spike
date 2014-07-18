module Jumpup
  module Action
    class Base
      def initialize(app)
        @app = app
      end

      def call(env)
        raise "#{self.class} does not implement `call`!"
      end
    end
  end
end

require_relative 'action/bundle_install'
require_relative 'action/cleanup'
require_relative 'action/db_migrate'
require_relative 'action/run_tests'
require_relative 'action/validate_config'

# Define the git module so we can "shortcut" the action classes
module Jumpup::Action::Git; end

require_relative 'action/git/pull_rebase'
require_relative 'action/git/push'
require_relative 'action/git/status_check'
