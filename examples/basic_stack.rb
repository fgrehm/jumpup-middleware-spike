#!/usr/bin/env ruby

require_relative '../lib/jumpup'

BasicStack = Jumpup::Builder.new do
  use Jumpup::Action::ValidateConfig
  use Jumpup::Action::Git::StatusCheck
  use Jumpup::Action::Cleanup
  use Jumpup::Action::Git::PullRebase
  use Jumpup::Action::BundleInstall
  use Jumpup::Action::DbMigrate
  use Jumpup::Action::RunTests
  use Jumpup::Action::Git::Push
end

if $0 == __FILE__
  env = {}
  BasicStack.call(env)
  puts env.inspect
end
