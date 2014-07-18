#!/usr/bin/env ruby

require_relative 'basic_stack'

module Jumpup
  module HipChat
    module Action
      class AnnounceStart < Jumpup::Action::Base
        def call(env)
          puts '- Announcing start of integration on hipchat'
          @app.call(env)
        end
      end

      class AnnounceFinished < Jumpup::Action::Base
        def call(env)
          puts '- Announcing end of integration on hipchat'
          @app.call(env)
        end
      end
    end
  end
end

if ARGV[0] == 'heroku'
  require_relative 'heroku'
  Stack = HerokuStack
  Stack.insert_before Jumpup::Heroku::Action::Start, Jumpup::HipChat::Action::AnnounceStart
else
  Stack = BasicStack
  Stack.insert_after Jumpup::Action::ValidateConfig, Jumpup::HipChat::Action::AnnounceStart
end

Stack.insert -1, Jumpup::HipChat::Action::AnnounceFinished

if $0 == __FILE__
  env = {}
  Stack.call(env)
  puts env.inspect
end
