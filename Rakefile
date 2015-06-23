# #!/usr/bin/env rake
require "bundler"
Bundler::GemHelper.install_tasks

require "rubocop/rake_task"
RuboCop::RakeTask.new

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)

task test: :spec
task default: [:rubocop, :spec]
